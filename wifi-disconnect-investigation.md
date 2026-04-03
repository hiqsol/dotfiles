# Wi-Fi Disconnect Loop Investigation: HUAWEI-Gkdh-5G on HP x360

## Problem

Persistent Wi-Fi issue where the connection to the 5GHz network ("HUAWEI-Gkdh-5G")
constantly drops and immediately reconnects. The physical location of the laptop has
not changed, and the connection used to be completely stable in this exact spot.
The issue started recently.

## System Info

- **Laptop:** HP x360
- **OS:** Ubuntu 22.04 with HWE kernel
- **Kernel:** 6.8.0-106-generic
- **Wi-Fi card:** MediaTek MT7925 (PCIe)
- **Driver:** mt7925e (in-tree)
- **Firmware:** Build 20231227093012a (Dec 2023)
- **Network:** HUAWEI-Gkdh-5G, 5180 MHz (channel 36), BSSID 30:E9:8E:A8:5B:49

## Investigation

### Step 1: Current connection status

```
wlo1    IEEE 802.11  ESSID:"HUAWEI-Gkdh-5G"
        Frequency:5.18 GHz  Access Point: 30:E9:8E:A8:5B:49
        Bit Rate=866.7 Mb/s   Tx-Power=3 dBm
        Link Quality=62/70  Signal level=-48 dBm
```

Signal is excellent. The radio link itself is fine.

### Step 2: Kernel logs reveal a deauth loop

Kernel logs show a repeating pattern every ~30 seconds:

```
wlo1: authenticated
wlo1: associate with 30:e9:8e:a8:5b:49 (try 1/3)
wlo1: RX AssocResp from 30:e9:8e:a8:5b:49 (capab=0x1411 status=0 aid=2)
wlo1: associated
wlo1: Limiting TX power to 23 (23 - 0) dBm as advertised by 30:e9:8e:a8:5b:49
    ... ~15-17 seconds later ...
wlo1: deauthenticating from 30:e9:8e:a8:5b:49 by local choice (Reason: 3=DEAUTH_LEAVING)
```

Key detail: **"by local choice"** — the laptop is disconnecting itself, not the router.

Approximately **2,000 disconnect/reconnect cycles occurred in a single day**.

### Step 3: NetworkManager logs show repeated suspend/wake cycles

```
manager: sleep: sleep requested (sleeping: no  enabled: yes)
device (wlo1): state change: activated -> deactivating (reason 'sleeping')
device (wlo1): supplicant interface state: completed -> disconnected
    ... seconds later ...
manager: sleep: wake requested (sleeping: yes  enabled: yes)
device (wlo1): Activation: starting connection 'HUAWEI-Gkdh-5G'
device (wlo1): Activation: successful, device activated.
```

The system requests sleep every ~30 seconds, tears down Wi-Fi, then immediately wakes.

### Step 4: Suspend fails due to mt7925e driver timeout

```
mt7925e 0000:01:00.0: Message 00020007 (seq 12) timeout
mt7925e 0000:01:00.0: PM: pci_pm_suspend(): mt7925_pci_suspend+0x0/0x2e0 [mt7925e] returns -110
mt7925e 0000:01:00.0: PM: failed to suspend async: error -110
PM: Some devices failed to suspend, or early wake event detected
```

The driver sends a command to the MT7925 firmware to enter low-power mode,
but the firmware never responds (error -110 = ETIMEDOUT). The kernel aborts
suspend and immediately resumes.

### Step 5: GNOME power settings trigger the loop

```
sleep-inactive-ac-type:      'nothing'     (no auto-suspend on AC)
sleep-inactive-battery-type: 'suspend'     (auto-suspend on battery)
sleep-inactive-battery-timeout: 1200       (after 20 minutes idle)
```

The system is on battery. GNOME triggers suspend after idle timeout. Suspend fails
due to mt7925e. System resumes. GNOME still considers the session idle and retries
suspend within ~30 seconds. Each attempt tears down and rebuilds the Wi-Fi connection.

### Step 6: Issue confirmed across kernel versions

```
reboot  6.8.0-106-generic  Fri Mar 20 10:47  still running
reboot  6.8.0-106-generic  Thu Mar 19 10:36
reboot  6.8.0-101-generic  Wed Mar 18 10:33   <-- suspend failures present here too
reboot  6.8.0-101-generic  Mon Mar 16 10:36   <-- and here
```

The mt7925e suspend bug exists on both 6.8.0-101 and 6.8.0-106.

## Root Cause

The **MediaTek MT7925 PCIe Wi-Fi driver** (`mt7925e`) has a known bug on kernel 6.8.x
where it fails to properly suspend. The driver sends command `0x00020007` to the
firmware chip to enter low-power mode, but the firmware (build Dec 2023) never responds,
causing a timeout.

This creates a **suspend loop**:

1. System goes idle on battery -> GNOME triggers suspend
2. mt7925e fails to suspend (firmware timeout, error -110)
3. Kernel aborts suspend, system immediately resumes
4. Wi-Fi was already torn down during the suspend attempt
5. Wi-Fi reconnects (~12-15 seconds)
6. System is still idle -> GNOME retries suspend -> loop

## Fixes

### 1. Immediate: disable auto-suspend on battery

Stops the suspend loop entirely. You lose automatic suspend on idle.

```bash
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing'
```

### 2. Try the ASPM workaround

The driver has a `disable_aspm` parameter (currently `N`). Disabling Active State
Power Management can fix the firmware communication timeout during suspend.

```bash
echo "options mt7925e disable_aspm=Y" | sudo tee /etc/modprobe.d/mt7925e.conf
```

Reboot required.

### 3. Update firmware (recommended)

The installed firmware is from December 2023. The Ubuntu 22.04 (Jammy) `linux-firmware`
package is based on version `20220329` and will never ship a meaningful update for the
MT7925 — the chip didn't even exist when that package was baselined.

The upstream `linux-firmware.git` repository has significantly newer firmware:

| File | Installed (Dec 2023) | Upstream (latest) |
|------|---------------------|-------------------|
| `WIFI_RAM_CODE_MT7925_1_1.bin` | 1,086,064 bytes | 1,246,968 bytes (+15%) |
| `WIFI_MT7925_PATCH_MCU_1_1_hdr.bin` | 210,656 bytes | 197,792 bytes |

Hashes are completely different — this is a substantial firmware update.

**Download from upstream:**

```bash
mkdir -p /tmp/mt7925-fw && cd /tmp/mt7925-fw
for f in WIFI_RAM_CODE_MT7925_1_1.bin WIFI_MT7925_PATCH_MCU_1_1_hdr.bin; do
    curl -sL -o "$f" \
        "https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/plain/mediatek/mt7925/$f"
done
```

**Install (backup first):**

```bash
sudo cp /lib/firmware/mediatek/mt7925/WIFI_RAM_CODE_MT7925_1_1.bin{,.bak}
sudo cp /lib/firmware/mediatek/mt7925/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin{,.bak}
sudo cp /tmp/mt7925-fw/WIFI_RAM_CODE_MT7925_1_1.bin /lib/firmware/mediatek/mt7925/
sudo cp /tmp/mt7925-fw/WIFI_MT7925_PATCH_MCU_1_1_hdr.bin /lib/firmware/mediatek/mt7925/
```

Reboot required. To rollback, restore the `.bak` files.

## Result

Firmware update applied and system rebooted. The new firmware loaded successfully:

```
mt7925e 0000:01:00.0: HW/SW Version: 0x8a108a10, Build Time: 20260106153007a
mt7925e 0000:01:00.0: WM Firmware Version: ____000000, Build Time: 20260106153120
```

- **Old firmware:** Build 20231227 (Dec 2023)
- **New firmware:** Build 20260106 (Jan 2026)
- **Zero deauth events or suspend failures after reboot**
- Connection stable on 5GHz, signal -52 dBm

The mt7925e suspend timeout bug (`Message 00020007 timeout`, error -110) is resolved
by the upstream firmware update. The suspend loop and Wi-Fi disconnect cycle no longer occur.

---

*Investigated and resolved 2026-03-21 on host x360.*

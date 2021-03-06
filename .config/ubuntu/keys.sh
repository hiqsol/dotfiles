#!/bin/bash

# Keyboard rate
gsettings set org.gnome.desktop.peripherals.keyboard repeat-interval 35
gsettings set org.gnome.desktop.peripherals.keyboard delay 200

# Switch layout
gsettings set org.gnome.desktop.input-sources xkb-options "['grp:shift_caps_switch','grp:alt_shift_toggle']"

GSETKEY="gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

KEY_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
"['$KEY_PATH/custom0/', '$KEY_PATH/custom1/', '$KEY_PATH/custom2/', '$KEY_PATH/custom3/', '$KEY_PATH/custom4/', '$KEY_PATH/custom5/']"

$GSETKEY/custom0/ name "KeePassXC"
$GSETKEY/custom0/ command "keepassxc"
$GSETKEY/custom0/ binding "<Super>K"

$GSETKEY/custom1/ name "Kill all browsers"
$GSETKEY/custom1/ command "pkill -9 'chromium|chrome|firefox'"
$GSETKEY/custom1/ binding "<Super>B"

$GSETKEY/custom4/ name "Google Chrome"
$GSETKEY/custom4/ command "google-chrome"
$GSETKEY/custom4/ binding "<Super>C"

$GSETKEY/custom5/ name "Firefox"
$GSETKEY/custom5/ command "firefox"
$GSETKEY/custom5/ binding "<Super>F"

$GSETKEY/custom2/ name "Screenshot Selection"
$GSETKEY/custom2/ command "gnome-screenshot --area"
$GSETKEY/custom2/ binding "<Shift><Super>Print"

$GSETKEY/custom3/ name "Gnome Terminal"
$GSETKEY/custom3/ command "x-terminal-emulator"
$GSETKEY/custom3/ binding "<Ctrl><Alt>T"

# Switch to Workspace
gsettings set org.gnome.shell.keybindings switch-to-application-1 "['<Super>F1']"
gsettings set org.gnome.shell.keybindings switch-to-application-2 "['<Super>F2']"
gsettings set org.gnome.shell.keybindings switch-to-application-3 "['<Super>F3']"
gsettings set org.gnome.shell.keybindings switch-to-application-4 "['<Super>F4']"
gsettings set org.gnome.shell.keybindings switch-to-application-5 "['<Super>F5']"
gsettings set org.gnome.shell.keybindings switch-to-application-6 "['<Super>F6']"
gsettings set org.gnome.shell.keybindings switch-to-application-7 "['<Super>F7']"
gsettings set org.gnome.shell.keybindings switch-to-application-8 "['<Super>F8']"
gsettings set org.gnome.shell.keybindings switch-to-application-9 "['<Super>F9']"

gsettings set org.gnome.desktop.wm.keybindings switch-group "[]"

gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-1  "['<Super>1']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-2  "['<Super>2']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-3  "['<Super>3']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-4  "['<Super>4']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-5  "['<Super>5']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-6  "['<Super>6']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-7  "['<Super>Q']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-8  "['<Super>W']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-9  "['<Super>E']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-10 "['<Super>R']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-11 "['<Super>T']"
gsettings set org.gnome.desktop.wm.keybindings switch-to-workspace-12 "['<Super>Y','<Super>Grave']"

gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-1  "['<Super><Ctrl>1']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-2  "['<Super><Ctrl>2']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-3  "['<Super><Ctrl>3']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-4  "['<Super><Ctrl>4']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-5  "['<Super><Ctrl>5']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-6  "['<Super><Ctrl>6']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-7  "['<Super><Ctrl>Q']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-8  "['<Super><Ctrl>W']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-9  "['<Super><Ctrl>E']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-10 "['<Super><Ctrl>R']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-11 "['<Super><Ctrl>T']"
gsettings set org.gnome.desktop.wm.keybindings move-to-workspace-12 "['<Super><Ctrl>Y']"

# Overview Workspaces
gsettings --schemadir ~/.local/share/gnome-shell/extensions/wsmatrix@martin.zurowietz.de/schemas/ set org.gnome.shell.extensions.wsmatrix-keybindings workspace-overview-toggle "['<Super><Shift>W']"


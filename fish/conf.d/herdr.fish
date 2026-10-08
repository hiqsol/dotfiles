# Herdr: notify when a long-running command in a pane finishes.
# Herdr only tracks agents, not plain shell commands (herdrdev/herdr#4680).
if status is-interactive; and set -q HERDR_PANE_ID; and command -q herdr
    # minimum command duration (seconds) that triggers a notification
    set -q HERDR_NOTIFY_MIN_SECONDS; or set -g HERDR_NOTIFY_MIN_SECONDS 10
    # interactive programs whose exit is not worth a notification
    set -q HERDR_NOTIFY_IGNORE; or set -g HERDR_NOTIFY_IGNORE \
        vi vim nvim nano less more man top htop btop btm ssh mosh tmux \
        lazygit yazi fzf claude codex agy opencode pi grok hermes herdr

    # children's user and system CPU time (ms) from /proc, as fish's `time` reads it
    function __herdr_rusage
        set -l f (string replace -r '.*\) ' '' < /proc/$fish_pid/stat | string split ' ')
        set -l tick (getconf CLK_TCK)
        math "$f[14] * 1000 / $tick"
        math "$f[15] * 1000 / $tick"
    end

    # compact duration from milliseconds: 340ms, 12.1s, 1m23s, 1h02m
    function __herdr_fmt_ms
        set -l ms (math --scale=0 $argv[1])
        if test $ms -lt 1000
            echo {$ms}ms
        else if test $ms -lt 60000
            echo (math --scale=1 $ms / 1000)s
        else if test $ms -lt 3600000
            set -l s (math --scale=0 $ms / 1000)
            printf '%dm%02ds\n' (math --scale=0 $s / 60) (math $s % 60)
        else
            set -l m (math --scale=0 $ms / 60000)
            printf '%dh%02dm\n' (math --scale=0 $m / 60) (math $m % 60)
        end
    end

    # Busy indicator: report the command as a "working" agent once it has run
    # for half a second; postexec cancels the pending report or releases it.
    function __herdr_busy_preexec --on-event fish_preexec
        set -l cmd (string split -f1 ' ' -- (string trim -- $argv[1]))
        test -n "$cmd"; or return
        contains -- $cmd $HERDR_NOTIFY_IGNORE; and return
        set -g __herdr_rusage_start (__herdr_rusage)
        set -l msg (string shorten -m 80 -- (string join ' ' -- $argv[1]))
        command sh -c 'sleep 0.5; exec herdr pane report-agent "$HERDR_PANE_ID" \
            --source user:fish --agent "$1" --state working --message "$2" \
            --seq "$(date +%s%N)"' herdr-busy $cmd $msg &>/dev/null &
        set -g __herdr_busy_pid $last_pid
        disown 2>/dev/null
    end

    function __herdr_notify_postexec --on-event fish_postexec
        set -l exit_status $status
        set -l cmd (string split -f1 ' ' -- (string trim -- $argv[1]))
        contains -- $cmd $HERDR_NOTIFY_IGNORE; and return
        # cancel a still-pending busy report, or release one already sent
        if set -q __herdr_busy_pid
            if not kill $__herdr_busy_pid 2>/dev/null
                command herdr pane release-agent $HERDR_PANE_ID \
                    --source user:fish --agent $cmd --seq (date +%s%N) &>/dev/null &
                disown 2>/dev/null
            end
            set -e __herdr_busy_pid
        end
        test $CMD_DURATION -ge (math "$HERDR_NOTIFY_MIN_SECONDS * 1000"); or return

        # one-line timing report (CPU time of external processes only)
        set -l usage (__herdr_rusage)
        set -q __herdr_rusage_start[2]; or set -g __herdr_rusage_start $usage
        set -l took (__herdr_fmt_ms $CMD_DURATION)
        set -l mark (set_color green)✔
        test $exit_status -ne 0; and set mark (set_color red)✘
        set -l rule ────────────
        printf '%s%s %s %s%s · %s · usr %s · sys %s %s%s\n' (set_color brblack) $rule \
            $mark $exit_status (set_color brblack) $took \
            (__herdr_fmt_ms (math $usage[1] - $__herdr_rusage_start[1])) \
            (__herdr_fmt_ms (math $usage[2] - $__herdr_rusage_start[2])) \
            $rule (set_color normal) >&2

        set -l title "✔ Command finished"
        set -l sound done
        if test $exit_status -ne 0
            set title "✘ Command failed ($exit_status)"
            set sound request
        end
        set -l body (string shorten -m 80 -- (string join ' ' -- $argv[1]))" — $took"
        # backgrounded so the prompt is not delayed
        command herdr notification show $title --body $body --sound $sound &>/dev/null &
        disown 2>/dev/null
    end
end

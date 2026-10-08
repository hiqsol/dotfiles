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

    # format milliseconds the way fish's `time` does
    function __herdr_fmt_ms
        if test $argv[1] -lt 1000
            printf '%8.2f millis' $argv[1]
        else if test $argv[1] -lt 60000
            printf '%8.2f secs  ' (math $argv[1] / 1000)
        else
            printf '%8.2f mins  ' (math $argv[1] / 60000)
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

        # timing report like fish's `time` (CPU time of external processes only)
        set -l usage (__herdr_rusage)
        set -q __herdr_rusage_start[2]; or set -g __herdr_rusage_start $usage
        echo >&2
        echo ________________________________________________________ >&2
        echo "Executed in"(__herdr_fmt_ms $CMD_DURATION) >&2
        echo "   usr time"(__herdr_fmt_ms (math $usage[1] - $__herdr_rusage_start[1])) >&2
        echo "   sys time"(__herdr_fmt_ms (math $usage[2] - $__herdr_rusage_start[2])) >&2
        echo >&2

        set -l secs (math --scale=0 "$CMD_DURATION / 1000")
        set -l took (math --scale=0 "$secs / 60")m(math "$secs % 60")s
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

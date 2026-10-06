#!/bin/sh

# Core functions for all POSIX shells (sh, bash, zsh)

reset_ssh_agent() {
    ### Predictable SSH authentication socket location
    ### XXX NOT $HOME because of `sudo -s`
    SOCK="/home/$USER/.ssh/ssh-agent.sock"
    # Find agent sockets owned by current user
    # shellcheck disable=SC2044 # agent socket paths have no spaces
    for sock in $(find /tmp -name "agent.*" -user "$USER" 2>/dev/null); do
        export SSH_AUTH_SOCK="$sock"
        # exit 1 = agent alive without identities, only 2 = no agent
        ssh-add -l >/dev/null 2>&1
        if [ $? -ne 2 ]; then
            echo "Agent link changed to $SSH_AUTH_SOCK"
            rm -f "$SOCK"
            ln -sf "$SSH_AUTH_SOCK" "$SOCK"
            export SSH_AUTH_SOCK="$SOCK"
            return 0
        fi
    done
}

restart_ssh_agent() {
    eval "$(ssh-agent -s)"
    reset_ssh_agent
}

md() {
    mkdir -p "$@" && cd "$@" || return
}


cdls() {
    cd "$1" || return
    if [ "$PWD" != "$HOME" ]; then
        # shellcheck disable=SC2154 # set in .shrc
        ls -F ${ls_options:+"$ls_options"}
    fi
}

# cd to /home/user/prj/organization/project
cdp() {
    cd "$(printf '%s\n' "$PWD" | cut -d/ -f1-6)" || return
}

# cd to /home/user/prj/organization/project/vendor/organization/PROJECT
cdvp() {
    cd "$(printf '%s\n' "$PWD" | cut -d/ -f1-9)" || return
}

# cd to /home/user/prj/organization/project/vendor/ORGANIZATION
cdv() {
    _cdv_6=$(printf '%s\n' "$PWD" | cut -d/ -f7)
    _cdv_7=$(printf '%s\n' "$PWD" | cut -d/ -f8)
    cd "$(printf '%s\n' "$PWD" | cut -d/ -f1-6)/${_cdv_6:-vendor}/${_cdv_7:-hiqdev}" || return
    unset _cdv_6 _cdv_7
}

hcd() {
    cd "$HOME/$1" || return
}

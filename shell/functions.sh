#!/bin/sh

# Core functions for all POSIX shells (sh, bash, zsh)

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

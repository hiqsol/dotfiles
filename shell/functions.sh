#!/bin/sh

# Core functions for all POSIX shells (sh, bash, zsh)

reset_ssh_agent() {
    ### Predictable SSH authentication socket location
    ### XXX NOT $HOME because of `sudo -s`
    SOCK="/home/$USER/.ssh/ssh-agent.sock"
    # Find agent sockets owned by current user
    for sock in $(find /tmp -name "agent.*" -user "$USER" 2>/dev/null); do
        export SSH_AUTH_SOCK="$sock"
        if ssh-add -l >/dev/null 2>&1; then
            echo "Agent link changed to $SSH_AUTH_SOCK"
            rm -f "$SOCK"
            ln -sf "$SSH_AUTH_SOCK" "$SOCK"
            export SSH_AUTH_SOCK="$SOCK"
            return 0
        fi
    done
}

restart_ssh_agent() {
    ssh-agent -s
    reset_ssh_agent
}

md() {
    mkdir -p "$@" && cd "$@"
}

fs() {
    ssh-keygen -f "$HOME/.ssh/known_hosts" -R "$1"
    s "$@"
}

cdls() {
    cd "$1"
    if [ "$PWD" != "$HOME" ]; then
        ls -F ${ls_options}
    fi
}


hcd() {
    cd "$HOME/$1"
}

psql_default() {
    if [ -z "$1" ]; then
        name=$(cat "$HOME/hostname")
    else
        name="$1"
        shift
    fi
    psql "$name" "$@"
}

docker_psql_default() {
    if [ -z "$1" ]; then
        host=pgsql
    else
        host="$1"
        shift
    fi
    if [ -z "$1" ]; then
        name=postgres
    else
        name="$1"
        shift
    fi
    psql -h "$host" -U postgres "$name" "$@"
}

dcc() {
    dc run -v "$HOME":"$HOME" -w "$PWD" --entrypoint composer php-fpm "$@"
}

drun() {
    docker run -it --rm -v "$HOME":"$HOME" -w "$PWD" "$@"
}

dphp54() { drun php:5.4-cli php "$@"; }
dphp81() { drun php:8.1-cli php "$@"; }
dphp84() { drun hiqdev/php:8.4-cli-alpine php "$@"; }
dphp() {
    ver="$1"; shift
    drun "php:$ver-cli" php "$@"
}

dbash() {
    docker exec -it "$1" bash -c "stty cols $COLUMNS rows $LINES && bash";
}

dpsql() {
    docker exec -it --user postgres "$1" sh -c "stty cols $COLUMNS rows $LINES && psql $2";
}

dcbash() {
    dc exec "$1" bash -c "stty cols $COLUMNS rows $LINES && bash";
}

dcpsql() {
    dc exec --user postgres pgsql sh -c "stty cols $COLUMNS rows $LINES && psql $*";
}

dcomposer() {
    docker compose run --rm -v "$SSH_AUTH_SOCK":/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent php-fpm sh -c "git config --global --add safe.directory /app && composer $*"
}

kh() {
    pod=$(kubectl get pods -n "$1" | grep "^$2" | cut -f 1 -d ' ')
    kubectl exec -i -t -n "$1" "$pod" -c "$2" "--" sh -c "bash || ash || sh"
}

path() {
    echo "$("cd" "$(dirname "$1")" && pwd)/$(basename "$1")"
}

linux_version() {
    command -v lsb_version && lsb_version -a
    cat /etc/*release
    cat /etc/issue*
    cat /proc/version
}

#!/usr/bin/env zsh

GREEN="\033[1;32m"
YELLOW="\033[1;33m"
NOCOLOR="\033[0m"

md() {
    mkdir -p "$@" && cd "$@"
}

fs() {
    ssh-keygen -f "/home/sol/.ssh/known_hosts" -R "$1"
    s $@
}

restart_ssh_agent() {
    ssh-agent -s
    reset_ssh_agent
}

reset_ssh_agent() {
    ### Predictable SSH authentication socket location
    ### XXX NOT $HOME because of `sudo -s`
    SOCK="/home/$USER/.ssh/ssh-agent.sock"
    for sock in `find /tmp -name "agent.*" -user sol 2>/dev/null`; do
        export SSH_AUTH_SOCK=$sock
        if ssh-add -l; then
            echo "Agent link changed to $SSH_AUTH_SOCK"
            rm -f $SOCK
            ln -sf $SSH_AUTH_SOCK $SOCK
            export SSH_AUTH_SOCK=$SOCK
            return 0
        fi
    done
}

cdls() {
    'cd' $1
    if [ $PWD != $HOME ]; then
        '/bin/ls' -F ${ls_options}
    fi
}

rehash() {
    source $HOME/.config/zsh/.zshenv
    source $HOME/.config/zsh/.zshrc
    builtin rehash
}

# cd to /home/user/prj/organization/project/vendor/organization/PROJECT
cdvp() {
    pts=(${(s:/:)PWD})
    cd "/$pts[1]/$pts[2]/$pts[3]/$pts[4]/$pts[5]/$pts[6]/$pts[7]/$pts[8]"
}

# cd to /home/user/prj/organization/project/vendor/ORGANIZATION
cdv() {
    pts=(${(s:/:)PWD})
    if [[ -z $pts[7] ]]; then
        pts[7]='hiqdev'
    fi
    if [[ -z $pts[6] ]]; then
        pts[6]='vendor'
    fi
    cd "/$pts[1]/$pts[2]/$pts[3]/$pts[4]/$pts[5]/$pts[6]/$pts[7]"
}

# cd to /home/user/prj/organization/PROJECT
cdp() {
    pts=(${(s:/:)PWD})
    cd "/$pts[1]/$pts[2]/$pts[3]/$pts[4]/$pts[5]"
}

# cd to /home/user/prj/organization/PROJECT/core
cdc() {
    pts=(${(s:/:)PWD})
    cd "/$pts[1]/$pts[2]/$pts[3]/$pts[4]/$pts[5]/core"
}

# cd to /home/user/prj/ORGANIZATION
cdo() {
    pts=(${(s:/:)PWD})
    cd "/$pts[1]/$pts[2]/$pts[3]/$pts[4]"
}

# cd to /home/user/GIVEN_DIR
hcd() {
    cd "$HOME/$1"
}

psql_default() {
    if [ -z "$1" ]; then
        name=`cat $HOME/hostname`
    else
        name=$1
        shift
    fi
    command psql $name "$@"
}

docker_psql_default() {
    if [ -z "$1" ]; then
        host=pgsql
    else
        host=$1
        shift
    fi
    if [ -z "$1" ]; then
        name=postgres
    else
        name=$1
        shift
    fi
    psql -h $host -U postgres $name "$@"
}

dcc() {
    dc run -v "$HOME":"$HOME" -w "$PWD" --entrypoint composer php-fpm $@
}

drun() {
    docker run -it --rm -v "$HOME":"$HOME" -w "$PWD" $@
}

dphp54() {
    drun php:5.4-cli php $@
}

dphp81() {
    drun php:8.1-cli php $@
}

dphp() {
    ver=$1;shift
    drun "php:$ver-cli" php $@
}

dbash() {
    docker exec -it $1 bash -c "stty cols $COLUMNS rows $LINES && bash";
}

dpsql() {
    docker exec -it --user postgres $1 sh -c "stty cols $COLUMNS rows $LINES && psql $2";
}

dcbash() {
    dc exec $1 bash -c "stty cols $COLUMNS rows $LINES && bash";
}

dcpsql() {
    dc exec --user postgres pgsql sh -c "stty cols $COLUMNS rows $LINES && psql $@";
}

kh() {
    pod=`kubectl get pods -n $1 | grep "^$2" | cut -f 1 -d ' '`
    kubectl exec -i -t -n $1 $pod -c $2 "--" sh -c "bash || ash || sh"
}

kp() {
    ns=$1
    name=${2:-mrdp}
    dbname=${3:-rcp}
    port=${4:-55432}
    pod=`kubectl get pods -n $ns | grep "^$name" | cut -f 1 -d ' '`
    echo "ns:$ns name:$name pod:$pod dbname:$dbname port:$port"
    cmd="kubectl --namespace $ns port-forward $pod $port:5432"
    echo $cmd
    eval "$cmd &"
    sleep 1
    psql --host=localhost --port=$port $dbname
    kill `ps | grep kubectl | head -n 1 | cut -f 1 -d 'p'`
}

# returns absolute path to file by given relative path
# also consider `realpath`
path() {
    echo "$("cd" "$(dirname "$1")" && pwd)/$(basename "$1")"
}

linux_version() {
    command -v lsb_version && lsb_version -a
    cat /etc/*release
    cat /etc/issue*
    cat /proc/version
}

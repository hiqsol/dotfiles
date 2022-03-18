#!/usr/bin/env zsh

GREEN="\033[1;32m"
YELLOW="\033[1;33m"
NOCOLOR="\033[0m"

md() {
    mkdir -p "$@" && cd "$@"
}

cdls() {
    'cd' $1
    if [ $PWD != $HOME ]; then
        'ls' -F ${ls_options}
    fi
}

rehash() {
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
    docker-compose exec $1 bash -c "stty cols $COLUMNS rows $LINES && bash";
}

dcpsql() {
    docker-compose exec --user postgres pgsql sh -c "stty cols $COLUMNS rows $LINES && psql $@";
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

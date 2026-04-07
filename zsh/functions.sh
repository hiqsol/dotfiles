#!/usr/bin/env zsh

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

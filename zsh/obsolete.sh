#!/usr/bin/env zsh

keepassxc() {
    file="$HOME/bin/keepassxc"

    if [ ! -x $file ]; then
        url=`curl --silent "https://api.github.com/repos/keepassxreboot/keepassxc/releases/latest" | jq -r '.assets[].browser_download_url | select (. | test("-x86_64.AppImage$"))'`
        curl -L $url -o $file
        chmod a+x $file
    fi

    $file $@
}

install_ripgrep() {
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb
    sudo dpkg -i ripgrep_0.10.0_amd64.deb && rm ripgrep_0.10.0_amd64.deb
}



install_desktop() {
    install_console
    sudo apt install openvpn openssh-server \
        keepassxc feh ffmpeg flameshot kruler \
        arandr qt5-style-kvantum \
        fonts-terminus gnome-font-viewer

    add_startup_apps
    add_screenlayout

    install_chrome
    install_zoom
    #install_skype
    install_slack
    install_telegram
}

add_startup_apps() {
    # keepassxc
    # skype
    # slack
    # telegram
}

add_screenlayout() {
    # FROM ~/.config/screenlayout
    # TO /usr/share/sddm/scripts/Xsetup
}

set_mime() {
    xdg-mime default google-chrome.desktop 'x-scheme-handler/http'
    xdg-mime default google-chrome.desktop 'x-scheme-handler/https'
}

install_skype() {
    tmp="$HOME/Downloads/skypeforlinux-64.deb"
    if ! [ -x $tmp ]; then
        # XXX wget -c doesn't work at their server :-/
        wget https://go.skype.com/skypeforlinux-64.deb -O $tmp
    fi
    sudo dpkg -i $tmp
    rm $tmp
}

install_slack() {
    # wget from slack.com/download
    # sudo dpkg -i
}

Telegram() {
    file="$HOME/sbin/Telegram/Telegram"
    if ! [ -x $file ]; then
        install_telegram
    fi

    $file $@
}

install_telegram() {
    if [ -x $HOME/sbin/Telegram/Telegram ]; then
        return
    fi
    cd ~/sbin
    wget -c https://telegram.org/dl/desktop/linux
    tar xf tsetup.*.tar.xz
    cd -
}

discord() {
    $file = /usr/bin/discord
    if ! [ -x $file ]; then
        install_discord
    fi

    $file $@
}

install_discord() {
    cd ~/sbin
    rm -f discord*.deb
    wget -c "https://discord.com/api/download?platform=linux"
    sudo dpkg -i discord*.deb
    cd -
}

install_chrome() {
    if [ -x /usr/bin/google-chrome ]; then
        return
    fi
    reinstall_chrome
}

reinstall_chrome() {
    wget -O ~/tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i ~/tmp/chrome.deb
}

install_dropbox() {
    cd ~
    wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
    cd -
    ~/.dropbox-dist/dropboxd &
}

install_zoom() {
    if [ -x /usr/bin/zoom ]; then
        return
    fi
	sudo apt install -y libegl1-mesa libgl1-mesa-glx libxcb-xtest0
    wget -c -O ~/tmp/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
	sudo dpkg -i ~/tmp/zoom.deb
}

install_viber() {
    wget -c -O ~/tmp/viber.deb https://download.cdn.viber.com/cdn/desktop/Linux/viber.deb
    sudo dpkg -i ~/tmp/viber.deb
}

install_google_drive_ocamlfuse() {
    sudo add-apt-repository ppa:alessandro-strada/ppa
    sudo apt update
    sudo apt install google-drive-ocamlfuse
}

persist_screenlayout() {
    # /usr/share/sddm/scripts/Xsetup
    # add ~/.screenlayout/wanted.sh
}

obsidian() {
    file="$HOME/sbin/obsidian"

    if [ ! -x $file ]; then
        curl -L https://github.com/obsidianmd/obsidian-releases/releases/download/v1.5.3/Obsidian-1.5.3.AppImage -o $file
        chmod a+x $file
    fi

    $file $@
}

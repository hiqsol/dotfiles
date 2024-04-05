GRC_ALIASES=true
[[ -s "/etc/profile.d/grc.sh" ]] && source /etc/grc.zsh
mtr() {
    echo mtr
}
unset -f mtr

install_console() {
    sudo apt install \
        net-tools curl \
        ripgrep grc fd-find bat \
        zsh tmux fuse git-lfs \
        ansible \
        npm python3-pip
    pip3 install neovim jedi pylint
}

install_devtools() {
    sudo apt install \
        build-essential cmake pkg-config
}

composerX() {
    version=$1
    shift
    file="$HOME/sbin/composer$version"

    if ! [ -x $file ]; then
        tmp="$HOME/tmp/composer-setup.php"
        wget https://getcomposer.org/installer -O $tmp
        php $tmp --install-dir=$HOME/sbin --filename=composer$version
        rm $tmp
        $file self --$version
    fi

    $file $@
}

docker-compose() {
    echo "\033[0;31mDEPRECATED use docker compose instead"
    file="$HOME/sbin/docker-compose"

    if [ ! -x $file ]; then
        curl -L https://github.com/docker/compose/releases/download/v2.23.1/docker-compose-linux-x86_64 -o $file
        chmod a+x $file
    fi

    $file $@
}

nginx-proxy-common() {
    # cd ~/prj/vendor
    # nginx-proxy-common start 1.2.3.4
    # PROFIT
    dir="$HOME/prj/hiqdev/nginx-proxy-common"
    file="$dir/nginx-proxy-common"

    if ! [ -d $dir ]; then
        git clone git@github.com:hiqdev/nginx-proxy-common $dir
    fi

    $file $@
}

certbot-auto() {
    file="$HOME/sbin/certbot-auto"

    if ! [ -x $file ]; then
        wget https://dl.eff.org/certbot-auto -O $file
        chmod a+x $file
    fi

    $file $@
}

ydl() {
    file="$HOME/sbin/youtube-dl"

    if [ ! -e "$file" ]; then
        wget https://github.com/yt-dlp/yt-dlp/releases/latest/download/yt-dlp -O $file
        chmod a+rx $file
    fi

    $file --add-metadata $@
}

nvm() {
    file="$HOME/.config/nvm/nvm.sh"

    if [ ! -x $file ]; then
        curl https://raw.githubusercontent.com/creationix/nvm/master/install.sh | bash
        source $file
    fi

    nvm $@
}

nvim() {
    file="$HOME/sbin/nvim"

    if [ ! -x $file ]; then
        curl -L https://github.com/neovim/neovim/releases/download/v0.9.5/nvim.appimage -o $file
        chmod a+x $file
    fi

    $file $@
}

vim8() {
    file="$HOME/sbin/vim8"

    if [ ! -x $file ]; then
        url=`curl --silent "https://api.github.com/repos/vim/vim-appimage/releases/latest" | jq -r 'first(.assets[].browser_download_url)'`
        curl -L $url -o $file
        chmod a+x $file
    fi

    $file $@
}

hub() {
    file="/usr/local/sbin/hub"

    if [ ! -x $file ]; then
        cd ~/tmp
        wget https://github.com/github/hub/releases/download/v2.14.2/hub-linux-amd64-2.14.2.tgz
        tar zvxvf hub-linux-amd64-2.14.2.tgz
        sudo ./hub-linux-amd64-2.14.2/install
        cp ./hub-linux-amd64-2.14.2/etc/hub.zsh_completion ~/.config/zsh/completion/_hub
        cd -
    fi

    $file $@
}

kubectl() {
    file="$HOME/sbin/kubectl"

    if [ ! -x $file ]; then
        url=https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
        curl -L $url -o $file
        chmod a+x $file
    fi

    $file $@
}

helm() {
    file="$HOME/sbin/helm"

    if [ ! -x $file ]; then
        url=https://get.helm.sh/helm-v3.7.0-linux-amd64.tar.gz
        curl -L $url -o ~/tmp/helm.tgz
        tar xf ~/tmp/helm.tgz -C ~/tmp
        mv ~/tmp/linux-amd64/helm $file
        chmod a+x $file
    fi

    $file $@
}

install_php_modules() { apt_php_modules install $@ }
remove_php_modules()  { apt_php_modules remove $@ }

apt_php_modules() {
    cmd=$1
    ver=$2
    if [[ -z $cmd ]]; then
        cmd="install"
    fi
    if [[ -z $ver ]]; then
        ver=$(get_php_version)
    fi
    echo "PHP $ver"

    if [[ $ver = "7.4" ]]; then
        opcache=""
    else
        opcache="php$ver-opcache"
    fi
    if [[ $ver = "7.4" ]]; then
        dom=""
    else
        dom="php$ver-dom"
    fi
    if [[ $ver = "8.1" ]]; then
        json=""
    else
        json="php$ver-json"
    fi
    sudo apt $cmd -y "php$ver-cli" "php$ver-common" \
        "php$ver-bcmath" "php$ver-gmp" \
        $json $dom $opcache \
        "php$ver-imap" "php$ver-mailparse" "php$ver-mbstring" \
        "php$ver-curl" "php$ver-imap" "php$ver-intl" \
        "php$ver-readline" "php$ver-soap" "php$ver-xml" "php$ver-zip"
}

get_php_version() {
    ver=`php -v`
    echo ${ver:4:3}
}

install_node12() {
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
    sudo apt -y install nodejs
}

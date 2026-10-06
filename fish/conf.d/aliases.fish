alias a='boxer abstract'
alias c='composerX 2'
alias d='docker'
alias dc='docker compose'
alias f='~/prj/instockcom/ferroctl/ferroctl'
alias g='git'
alias ga='gita'
alias gt='ga ll'
alias gtree='eza -laT --git-ignore --git -I ".git|node_modules|vendor" ~/prj'
alias k='kubectl'
alias L='less -R'
alias s='ssh'
alias v='nvim'
alias dco='dcomposer'
alias gr='rg --no-heading'
alias lt='eza -laT -I ".git|.venv|__pycache__"'
alias cdd='cd ~/.config'
alias grab='g grab'
alias lgrab='g lgrab'
alias llama="gemini --agent llama3-agent"
alias y="yazi"
alias lg="lazygit"
alias rga="ripgrep-all"
alias ls="eza"
alias l="eza -la"
alias ll="eza -lAh"
alias gm='gemini'
alias phm='phpuvm'
alias upgrade='sudo apt update && sudo apt upgrade'
alias upall='~/.local/bin/mise self-update && ~/.local/bin/mise upgrade && upgrade'

alias p='psql_default'
alias c1='composerX 1'
alias c2='composerX 2'
alias d1='du -hd1'
alias dp='docker_psql_default'
alias ws="ssh -o 'ConnectionAttempts 300'"
alias gir='grep -IR'
alias grn='rg --no-line-number --no-filename'
alias girp='grep -IR --include=\*.php --exclude-dir=vendor'
alias vim='nvim'
alias ovim='/usr/bin/vim'
alias vimdiff='v -d'
alias zconfig='v ~/.config/zsh/.zshrc'
alias x509="openssl x509 -text -noout -in"
alias ymp3="yt-dlp --add-metadata --extract-audio --audio-format mp3 -o '%(title)s.%(ext)s'"
alias ypl3="ymp3 -w --no-post-overwrites --download-archive .archive.txt --ignore-errors"
alias clone='g clone'
alias lclone='g lclone'
alias nwget='wget --no-check-certificate'
alias rmsshkey='ssh-keygen -f "$HOME/.ssh/known_hosts" -R'
alias ls-tmux="tmux list-panes -aF '#{session_name}:#{window_index}:#{pane_index}	#{pane_tty}	#{pane_pid}	#{pane_current_command}'"

alias ,='cd ..'
alias ,,='cd ../..'
alias ,,,='cd ../../..'
alias ,,,,='cd ../../../..'
alias ,,,,,='cd ../../../../..'
alias ,,,,,,='cd ../../../../../..'

# cd to /home/user/prj/organization/project
function cdp
    set parts (string split -n / -- $PWD)
    cd /(string join / -- $parts[1..5])
end

# cd to /home/user/prj/organization/project/vendor/organization/PROJECT
function cdvp
    set parts (string split -n / -- $PWD)
    cd /(string join / -- $parts[1..8])
end

# cd to /home/user/prj/organization/project/vendor/ORGANIZATION
function cdv
    set parts (string split -n / -- $PWD)
    set -q parts[6]; or set parts[6] vendor
    set -q parts[7]; or set parts[7] hiqdev
    cd /(string join / -- $parts[1..7])
end

function psql_default
    if test -z "$argv[1]"
        set name (cat $HOME/hostname)
    else
        set name $argv[1]
        set -e argv[1]
    end
    psql $name $argv
end

function docker_psql_default
    set host pgsql
    set name postgres
    if test -n "$argv[1]"
        set host $argv[1]
        set -e argv[1]
    end
    if test -n "$argv[1]"
        set name $argv[1]
        set -e argv[1]
    end
    psql -h $host -U postgres $name $argv
end

function drun
    docker run -it --rm -v $HOME:$HOME -w $PWD $argv
end

function dphp54
    drun php:5.4-cli php $argv
end

function dphp81
    drun php:8.1-cli php $argv
end

function dphp84
    drun hiqdev/php:8.4-cli-alpine php $argv
end

function dphp
    drun php:$argv[1]-cli php $argv[2..-1]
end

function dbash
    docker exec -it $argv[1] bash -c "stty cols $COLUMNS rows $LINES && bash"
end

function dpsql
    docker exec -it --user postgres $argv[1] sh -c "stty cols $COLUMNS rows $LINES && psql $argv[2]"
end

function dcpsql
    dc exec --user postgres pgsql sh -c "stty cols $COLUMNS rows $LINES && psql $argv"
end

function kh
    set pod (kubectl get pods -n $argv[1] | grep "^$argv[2]" | cut -f 1 -d ' ')
    kubectl exec -i -t -n $argv[1] $pod -c $argv[2] -- sh -c "bash || ash || sh"
end

function linux_version
    command -q lsb_release; and lsb_release -a
    cat /etc/*release
    cat /etc/issue*
    cat /proc/version
end

function dccomposer
    docker compose run --rm -v $SSH_AUTH_SOCK:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent php-fpm sh -c "git config --global --add safe.directory /app && composer $argv"
end

function dcbash
    dc exec $argv[1] bash -c "stty cols $COLUMNS rows $LINES && bash"
end

function dcomposer
    docker run --rm --entrypoint composer \
        --user (id -u):(id -g) \
        -e COMPOSER_HOME=/tmp/composer \
        -e SSH_AUTH_SOCK=/ssh-agent \
        -e "GIT_SSH_COMMAND=ssh -F /dev/null -o StrictHostKeyChecking=accept-new -o UserKnownHostsFile=/tmp/known_hosts" \
        -v /etc/passwd:/etc/passwd:ro \
        -v /etc/group:/etc/group:ro \
        -v "$SSH_AUTH_SOCK:/ssh-agent" \
        -v "$PWD:/app" \
        -w /app \
        ghcr.io/hiqdev/docker-ci-images/php-nginx:8.4 \
        $argv
end

function composerX
    set composer_version $argv[1]
    set -e argv[1]
    set dir "$HOME/.local/bin"
    set file "$dir/composer$composer_version"

    if not test -x "$file"
        set tmp (mktemp)
        mkdir -p "$dir"
        wget https://getcomposer.org/installer -O "$tmp"
        php "$tmp" --install-dir="$dir" --filename="composer$composer_version"
        rm "$tmp"
        "$file" self --$composer_version
    end

    "$file" $argv
end

alias a='boxer abstract'
alias c='composerX 2'
alias d='docker'
alias dc='docker compose'
alias f='~/prj/instockcom/ferroctl/ferroctl'
alias g='git'
alias ga='gita'
alias gt='ga ll'
alias gtree='eza -laT --git-ignore --git -I ".git|node_modules|vendor" ~/prj'
alias L='less -R'
alias s='ssh'
alias v='nvim'
alias dco='dcomposer'
alias gr='rg --no-heading'
alias lt='eza -laT -I ".git|.venv|__pycache__"'
alias cdd='cd ~/.config'
alias cdm='cd ~/prj/hiqsol/nanokai/home/kai/memory'
alias cdq='cd ~/prj/hiqsol/quotes'
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

alias ,='cd ..'
alias ,,='cd ../..'
alias ,,,='cd ../../..'
alias ,,,,='cd ../../../..'
alias ,,,,,='cd ../../../../..'
alias ,,,,,,='cd ../../../../../..'

function dccomposer
    docker compose run --rm -v $SSH_AUTH_SOCK:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent php-fpm sh -c "git config --global --add safe.directory /app && composer $argv"
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

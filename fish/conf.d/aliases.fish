alias a='boxer abstract'
alias c='boxer claude'
alias d='docker'
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
alias lt='eza -laT -I .git'
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

function dcomposer
    docker compose run --rm -v $SSH_AUTH_SOCK:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent php-fpm sh -c "git config --global --add safe.directory /app && composer $argv"
end

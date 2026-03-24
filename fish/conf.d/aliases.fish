alias c='boxer claude'
alias d='docker'
alias f='~/prj/instockcom/ferroctl/ferroctl'
alias g='git'
alias l='la'
alias L='less -R'
alias s='ssh'
alias v='nvim'
alias co='composer'
alias dc='docker compose'
alias dco='dcomposer'
function dcomposer; docker compose run --rm -v $SSH_AUTH_SOCK:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent php-fpm sh -c "git config --global --add safe.directory /app && composer $argv"; end
alias gr='rg --no-heading'
alias fd='fdfind'
alias lo='local-open'
alias sl='ssh-add -l'
alias vd='v -d'
alias cat='batcat'
alias cdd='cd ~/.config'
alias cdm='cd ~/prj/hiqsol/nanokai/home/kai/memory'
alias cdq='cd ~/prj/hiqsol/quotes'
alias grab='g grab'
alias lgrab='g lgrab'
alias rehash='source ~/.config/fish/conf.d/aliases.fish'
alias phm='phpuvm'
alias upgrade='sudo apt update && sudo apt upgrade'

# cd to /home/user/prj/organization/PROJECT
function cdp; cd (string split / -- $PWD | head -6 | string join /); end
# cd to /home/user/prj/ORGANIZATION
function cdo; cd (string split / -- $PWD | head -5 | string join /); end
# cd to /home/user/prj/organization/PROJECT/core
function cdc; cd (string split / -- $PWD | head -6 | string join /)/core; end

alias ,='cd ..'
alias ,,='cd ../..'
alias ,,,='cd ../../..'
alias ,,,,='cd ../../../..'

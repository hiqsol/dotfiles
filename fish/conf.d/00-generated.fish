# GENERATED from shell/shell.toml by scripts/gen-shell — do not edit

set -gx BLOCKSIZE K
set -gx CLICOLOR 1
set -gx LSCOLORS Gxfxcxdxbxegedabagacad
set -gx LANGUAGE en_US:en
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx PAGER 'less -S'
set -gx EDITOR nvim
set -gx VISUAL nvim
set -gx BROWSER x-www-browser:local-open
set -gx NVIM_LOG_FILE "$HOME/.cache/nvim/log"
set -gx RIPGREP_CONFIG_PATH "$HOME/.config/ripgrep/.ripgreprc"
set -gx LESS '-i -x4 -M -R -F -X'
set -gx LESS_TERMCAP_mb \e'[1;31m'
set -gx LESS_TERMCAP_md \e'[1;36m'
set -gx LESS_TERMCAP_me \e'[0m'
set -gx LESS_TERMCAP_so \e'[38;5;016m'\e'[48;5;220m'
set -gx LESS_TERMCAP_se \e'[0m'
set -gx LESS_TERMCAP_us \e'[1;32m'
set -gx LESS_TERMCAP_ue \e'[0m'
set -gx LESS_TERMCAP_zz \e'[0m'

alias c='composerX 2'
alias d='docker'
alias f='~/prj/instockcom/ferroctl/ferroctl'
alias g='git'
alias k='kubectl'
alias l='eza -la'
alias p='psql_default'
alias s='ssh'
alias v='nvim'
alias y='yazi'
alias L='less -R'
alias cdd='cd ~/.config'
alias ,='cd ..'
alias ,,='cd ../..'
alias ,,,='cd ../../..'
alias ,,,,='cd ../../../..'
alias ,,,,,='cd ../../../../..'
alias ,,,,,,='cd ../../../../../..'
alias ls='eza'
alias ll='eza -lAh'
alias cat='bat'
alias lt='eza -laT -I ".git|.venv|__pycache__"'
alias gtree='eza -laT --git-ignore --git -I ".git|node_modules|vendor" ~/prj'
alias d1='du -hd1'
alias gt='ga ll'
alias grab='g grab'
alias lgrab='g lgrab'
alias clone='g clone'
alias lclone='g lclone'
alias lg='lazygit'
alias gr='rg --no-heading'
alias grn='rg --no-line-number --no-filename'
alias gir='grep -IR'
alias girp='grep -IR --include=\\*.php --exclude-dir=vendor'
alias vim='nvim'
alias ovim='/usr/bin/vim'
alias vimdiff='v -d'
alias zconfig='v ~/.config/zsh/.zshrc'
alias dc='docker compose'
alias dphp54='drun php:5.4-cli php'
alias dphp81='drun php:8.1-cli php'
alias dphp84='drun hiqdev/php:8.4-cli-alpine php'
alias dco='dcomposer'
alias dp='docker_psql_default'
alias c1='composerX 1'
alias c2='composerX 2'
alias phm='phpuvm'
alias ws="ssh -o 'ConnectionAttempts 300'"
alias rmsshkey='ssh-keygen -f "$HOME/.ssh/known_hosts" -R'
alias nwget='wget --no-check-certificate'
alias x509='openssl x509 -text -noout -in'
alias ymp3="yt-dlp --add-metadata --extract-audio --audio-format mp3 -o '%(title)s.%(ext)s'"
alias ypl3='ymp3 -w --no-post-overwrites --download-archive .archive.txt --ignore-errors'
alias ls-tmux="tmux list-panes -aF '#{session_name}:#{window_index}:#{pane_index}	#{pane_tty}	#{pane_pid}	#{pane_current_command}'"
alias upgrade='sudo apt update && sudo apt upgrade'
alias upall='~/.local/bin/mise self-update && ~/.local/bin/mise upgrade && upgrade'

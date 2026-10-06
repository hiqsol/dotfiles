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

status is-interactive; or return

abbr -a -- c 'composerX 2'
abbr -a -- d 'docker'
abbr -a -- f '~/prj/instockcom/ferroctl/ferroctl'
abbr -a -- g 'git'
abbr -a -- k 'kubectl'
abbr -a -- l 'eza -la'
abbr -a -- p 'psql_default'
abbr -a -- s 'ssh'
abbr -a -- v 'nvim'
abbr -a -- y 'yazi'
abbr -a -- L 'less -R'
abbr -a -- cdd 'cd ~/.config'
abbr -a -- , 'cd ..'
abbr -a -- ,, 'cd ../..'
abbr -a -- ,,, 'cd ../../..'
abbr -a -- ,,,, 'cd ../../../..'
abbr -a -- ,,,,, 'cd ../../../../..'
abbr -a -- ,,,,,, 'cd ../../../../../..'
abbr -a -- ls 'eza'
abbr -a -- ll 'eza -lAh'
abbr -a -- cat 'bat'
abbr -a -- lt 'eza -laT -I ".git|.venv|__pycache__"'
abbr -a -- gtree 'eza -laT --git-ignore --git -I ".git|node_modules|vendor" ~/prj'
abbr -a -- d1 'du -hd1'
abbr -a -- grab 'git grab'
abbr -a -- lgrab 'git lgrab'
abbr -a -- clone 'git clone'
abbr -a -- lclone 'git lclone'
abbr -a -- lg 'lazygit'
abbr -a -- gr 'rg --no-heading'
abbr -a -- grn 'rg --no-line-number --no-filename'
abbr -a -- gir 'grep -IR'
abbr -a -- girp "grep -IR --include='*.php' --exclude-dir=vendor"
abbr -a -- vim 'nvim'
abbr -a -- ovim '/usr/bin/vim'
abbr -a -- vimdiff 'nvim -d'
abbr -a -- zconfig 'nvim ~/.config/zsh/.zshrc'
abbr -a -- dc 'docker compose'
abbr -a -- dphp54 'drun php:5.4-cli php'
abbr -a -- dphp81 'drun php:8.1-cli php'
abbr -a -- dphp84 'drun hiqdev/php:8.4-cli-alpine php'
abbr -a -- dco 'dcomposer'
abbr -a -- dp 'docker_psql_default'
abbr -a -- c1 'composerX 1'
abbr -a -- c2 'composerX 2'
abbr -a -- phm 'phpuvm'
abbr -a -- ws "ssh -o 'ConnectionAttempts 300'"
abbr -a -- rmsshkey 'ssh-keygen -f "$HOME/.ssh/known_hosts" -R'
abbr -a -- nwget 'wget --no-check-certificate'
abbr -a -- x509 'openssl x509 -text -noout -in'
abbr -a -- ymp3 "yt-dlp --add-metadata --extract-audio --audio-format mp3 -o '%(title)s.%(ext)s'"
abbr -a -- ypl3 "yt-dlp --add-metadata --extract-audio --audio-format mp3 -o '%(title)s.%(ext)s' -w --no-post-overwrites --download-archive .archive.txt --ignore-errors"
abbr -a -- ls-tmux "tmux list-panes -aF '#{session_name}:#{window_index}:#{pane_index}	#{pane_tty}	#{pane_pid}	#{pane_current_command}'"
abbr -a -- upgrade 'sudo apt update && sudo apt upgrade'
abbr -a -- upall '~/.local/bin/mise self-update && ~/.local/bin/mise upgrade && sudo apt update && sudo apt upgrade'

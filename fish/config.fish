set -x PATH $HOME/sbin $HOME/bin $HOME/.config/composer/vendor/bin $HOME/.local/bin $HOME/go/bin /usr/local/go/bin $PATH
if set -q KREW_ROOT
    set -gx PATH $KREW_ROOT/bin $PATH
else
    set -gx PATH $HOME/.krew/bin $PATH
end
set -x EDITOR nvim
set -x VISUAL nvim
set -x NVIM_LOG_FILE $HOME/.cache/nvim/log

# Keep in sync with shell/.shrc
set -gx BLOCKSIZE K
set -gx CLICOLOR 1
set -gx LSCOLORS Gxfxcxdxbxegedabagacad
set -gx LANGUAGE en_US:en
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx PAGER 'less -S'
set -gx BROWSER 'x-www-browser:local-open'
set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/.ripgreprc
# fd is `fdfind` when installed from Debian/Ubuntu apt, `fd` otherwise (e.g. mise)
if command -q fdfind
    set -gx FZF_DEFAULT_COMMAND 'fdfind --type f --strip-cwd-prefix -H -L -E .git'
else
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix -H -L -E .git'
end

# less config
set -gx LESS '-i -x4 -M -R -F -X'
set -gx LESS_TERMCAP_mb \e'[1;31m'                 # begin bold
set -gx LESS_TERMCAP_md \e'[1;36m'                 # begin blink
set -gx LESS_TERMCAP_me \e'[0m'                    # reset bold/blink
set -gx LESS_TERMCAP_so \e'[38;5;016m'\e'[48;5;220m' # begin reverse video
set -gx LESS_TERMCAP_se \e'[0m'                    # reset reverse video
set -gx LESS_TERMCAP_us \e'[1;32m'                 # begin underline
set -gx LESS_TERMCAP_ue \e'[0m'                    # reset underline
set -gx LESS_TERMCAP_zz \e'[0m'                    # the last for better output of `env`

# pixi before mise activate, so mise-managed tools take precedence over pixi ones
set -gx PATH "$HOME/.pixi/bin" $PATH

# Activate mise first so other tools are in the path
$HOME/.local/bin/mise activate fish | source

if status is-interactive
    direnv hook fish | source
    zoxide init fish | source
    starship init fish | source
end

if test -f ~/.local/.shenv.fish
    source ~/.local/.shenv.fish
end

# Project-local bins go LAST so an untrusted repo cannot shadow system commands.
# Drop any copies inherited from a parent shell first, then append.
for __p in ./vendor/bin ./node_modules/.bin
    while set -l i (contains -i -- $__p $PATH)
        set -e PATH[$i]
    end
    set -gx PATH $PATH $__p
end
set -e __p

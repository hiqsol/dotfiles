set -x PATH ./vendor/bin ./node_modules/.bin $HOME/sbin $HOME/bin $HOME/.config/composer/vendor/bin $HOME/.local/bin $HOME/go/bin /usr/local/go/bin $PATH
set -x EDITOR nvim
set -x VISUAL nvim
set -x NVIM_LOG_FILE $HOME/.cache/nvim/log

# Activate mise first so other tools are in the path
$HOME/.local/bin/mise activate fish | source

if status is-interactive
    direnv hook fish | source
    nvm use lts >/dev/null
    zoxide init fish | source
    starship init fish | source
    atuin init fish | source
end

if test -f ~/.local/.shenv.fish
    source ~/.local/.shenv.fish
end

set -gx PATH "/home/sol/.pixi/bin" $PATH

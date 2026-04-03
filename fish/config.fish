set -x PATH /home/sol/.local/bin $PATH
set -x PATH /home/sol/bin $PATH
set -x EDITOR nvim
set -x VISUAL nvim
set -x NVIM_LOG_FILE $HOME/.cache/nvim/log
if status is-interactive
    direnv hook fish | source
    nvm use lts >/dev/null
end
if test -f ~/.local/.shenv.fish
    source ~/.local/.shenv.fish
end
/home/sol/.local/bin/mise activate fish | source

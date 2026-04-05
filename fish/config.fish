set -x PATH /home/sol/.local/bin $PATH
set -x PATH /home/sol/bin $PATH
set -x EDITOR nvim
set -x VISUAL nvim
set -x NVIM_LOG_FILE $HOME/.cache/nvim/log

# Activate mise first so other tools are in the path
/home/sol/.local/bin/mise activate fish | source

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

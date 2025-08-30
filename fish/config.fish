set -x PATH /home/sol/bin $PATH
if status is-interactive
    direnv hook fish | source
    nvm use lts >/dev/null
end

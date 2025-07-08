if status is-interactive
    direnv hook fish | source
    nvm use lts >/dev/null
end

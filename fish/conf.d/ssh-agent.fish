if status is-interactive
    set -l SOCK /home/$USER/.ssh/ssh-agent.sock
    if test -n "$SSH_AUTH_SOCK"; and test "$SSH_AUTH_SOCK" != "$SOCK"
        ln -sf $SSH_AUTH_SOCK $SOCK
    end
    set -gx SSH_AUTH_SOCK $SOCK
    if not test -S "$SSH_AUTH_SOCK"
        reset_ssh_agent
    end
end

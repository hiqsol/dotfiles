if status is-interactive
    set -l SOCK /home/$USER/.ssh/ssh-agent.sock
    # Link to the resolved socket: wrappers (herdr) may hand us a link to $SOCK
    set -l real (path resolve -- "$SSH_AUTH_SOCK")
    if test -n "$SSH_AUTH_SOCK"; and test "$real" != "$SOCK"; and test -S "$real"
        ln -sfn $real $SOCK
    end
    set -gx SSH_AUTH_SOCK $SOCK
    if not test -S "$SSH_AUTH_SOCK"
        reset_ssh_agent
    end
end

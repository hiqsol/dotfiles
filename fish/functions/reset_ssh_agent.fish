function reset_ssh_agent
    ### Predictable SSH authentication socket location
    ### XXX NOT $HOME because of `sudo -s`
    set -l SOCK "/home/$USER/.ssh/ssh-agent.sock"
    for sock in (find /tmp -name "agent.*" -user $USER 2>/dev/null)
        set -gx SSH_AUTH_SOCK $sock
        # exit 1 = agent alive without identities, only 2 = no agent
        ssh-add -l >/dev/null 2>&1
        if test $status -ne 2
            echo "Agent link changed to $SSH_AUTH_SOCK"
            rm -f $SOCK
            ln -sf $SSH_AUTH_SOCK $SOCK
            set -gx SSH_AUTH_SOCK $SOCK
            return 0
        end
    end
end

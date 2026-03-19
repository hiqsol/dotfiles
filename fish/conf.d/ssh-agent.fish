if status is-login; and test -z "$SSH_AUTH_SOCK"
    reset_ssh_agent
end

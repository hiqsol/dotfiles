function restart_ssh_agent
    eval (ssh-agent -c)
    reset_ssh_agent
end

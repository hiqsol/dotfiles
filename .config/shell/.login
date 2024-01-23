#!/bin/sh

# terminal settings
#stty -istrip crt erase 
stty -ixon

# allow messages to be displayed on screen
mesg y

# my motd
echo; quotes; echo

# Enable ssh-agent
if [ -z $SSH_AUTH_SOCK ]; then
    reset_ssh_agent
fi

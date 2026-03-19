#!/bin/sh

# terminal settings
#stty -istrip crt erase 
stty -ixon

# allow messages to be displayed on screen
mesg y

# my motd
echo; quotes; echo

# ssh-agent is now handled in .shrc

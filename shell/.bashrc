#!/bin/bash

# Source global shrc
[ -f ~/.shrc ] && . ~/.shrc

# Source global aliases
[ -f ~/.aliases ] && . ~/.aliases

# Activate tools
if [[ $- == *i* ]]; then
    eval "$(~/.local/bin/mise activate bash)"
    eval "$(zoxide init bash)"
    eval "$(starship init bash)"
    eval "$(atuin init bash)"
    eval "$(direnv hook bash)"
fi

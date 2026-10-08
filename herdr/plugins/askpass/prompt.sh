#!/bin/sh
# prompt.sh - read a password with echo off, hand it to bin/askpass via $ASKPASS_FIFO
# (an empty line on cancel, so askpass never hangs)
trap 'stty echo; echo >"$ASKPASS_FIFO"; exit 1' INT HUP TERM
printf '%s' "${ASKPASS_PROMPT:-Password: }"
stty -echo
IFS= read -r pw || pw=
stty echo
printf '%s\n' "$pw" >"$ASKPASS_FIFO"

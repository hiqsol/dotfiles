#! /usr/local/bin/zsh

export ZDOTDIR=~/.config/zsh
export PATH=./vendor/bin:./node_modules/.bin:~/sbin:~/bin:~/.config/composer/vendor/bin:~/.local/bin:~/go/bin:/usr/local/go/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

if ! xset q > /dev/null 2> /dev/null; then
    [ -z "$DISPLAY" ] && DISPLAY=":0"
    export DISPLAY
fi

# GENERATED from shell/shell.toml by scripts/gen-shell — do not edit
# shellcheck shell=sh

# drop existing copies of $2, then add it at the start (pre) or end (app)
_path_add() {
    PATH=":$PATH:"
    while case $PATH in *":$2:"*) true ;; *) false ;; esac; do
        PATH="${PATH%%":$2:"*}:${PATH#*":$2:"}"
    done
    PATH=${PATH#:}
    PATH=${PATH%:}
    case $1 in
        pre) PATH="$2${PATH:+:$PATH}" ;;
        app) PATH="${PATH:+$PATH:}$2" ;;
    esac
}
_path_add pre /usr/local/go/bin
_path_add pre "$HOME/go/bin"
_path_add pre "$HOME/.local/bin"
_path_add pre "$HOME/.config/composer/vendor/bin"
_path_add pre "$HOME/bin"
_path_add pre "$HOME/sbin"
_path_add pre "$HOME/.krew/bin"
_path_add pre "$HOME/.local/share/mise/shims"
_path_add app ./vendor/bin
_path_add app ./node_modules/.bin
unset -f _path_add
export PATH

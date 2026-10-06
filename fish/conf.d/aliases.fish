# Simple aliases live in shell/shell.toml (generated into 00-generated.fish).
# Only functions that change the current shell (cd); commands are in ~/.config/bin.

# cd to /home/user/prj/organization/project
function cdp
    set parts (string split -n / -- $PWD)
    cd /(string join / -- $parts[1..5])
end

# cd to /home/user/prj/organization/project/vendor/organization/PROJECT
function cdvp
    set parts (string split -n / -- $PWD)
    cd /(string join / -- $parts[1..8])
end

# cd to /home/user/prj/organization/project/vendor/ORGANIZATION
function cdv
    set parts (string split -n / -- $PWD)
    set -q parts[6]; or set parts[6] vendor
    set -q parts[7]; or set parts[7] hiqdev
    cd /(string join / -- $parts[1..7])
end

function md
    mkdir -p $argv; and cd $argv[1]
end

function hcd
    cd $HOME/$argv[1]
end

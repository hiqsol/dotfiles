set -x PATH $HOME/sbin $HOME/bin $HOME/.config/composer/vendor/bin $HOME/.local/bin $HOME/go/bin /usr/local/go/bin $PATH
if set -q KREW_ROOT
    set -gx PATH $KREW_ROOT/bin $PATH
else
    set -gx PATH $HOME/.krew/bin $PATH
end

# Simple env vars live in shell/shell.toml (generated into conf.d/00-generated.fish)
# fd is `fdfind` when installed from Debian/Ubuntu apt, `fd` otherwise (e.g. mise)
if command -q fdfind
    set -gx FZF_DEFAULT_COMMAND 'fdfind --type f --strip-cwd-prefix -H -L -E .git'
else
    set -gx FZF_DEFAULT_COMMAND 'fd --type f --strip-cwd-prefix -H -L -E .git'
end

# pixi before mise activate, so mise-managed tools take precedence over pixi ones
set -gx PATH "$HOME/.pixi/bin" $PATH

# Activate mise first so other tools are in the path
if test -x $HOME/.local/bin/mise
    $HOME/.local/bin/mise activate fish | source
else
    # lazy installer: the only one, mise brings everything else
    function mise
        $HOME/.config/bin/install-mise; and $HOME/.local/bin/mise $argv
    end
end

if status is-interactive
    zoxide init fish | source
    starship init fish | source

    # grc colouring for the same commands as /etc/grc.zsh in zsh
    # (not /etc/grc.fish: it wraps ls/cat/tail and breaks quoting with eval)
    if type -q grc; and test -f /etc/grc.zsh
        for cmd in (sed -n '/^cmds=(/,/^)/{/[()]/!p}' /etc/grc.zsh | string trim)
            if type -q $cmd; and not functions -q $cmd
                function $cmd --inherit-variable cmd --wraps=$cmd
                    if isatty stdout
                        grc --colour=auto $cmd $argv
                    else
                        command $cmd $argv
                    end
                end
            end
        end
    end
end

if test -f ~/.local/.shenv.fish
    source ~/.local/.shenv.fish
end

# Project-local bins go LAST so an untrusted repo cannot shadow system commands.
# Drop any copies inherited from a parent shell first, then append.
for __p in ./vendor/bin ./node_modules/.bin
    while set -l i (contains -i -- $__p $PATH)
        set -e PATH[$i]
    end
    set -gx PATH $PATH $__p
end
set -e __p

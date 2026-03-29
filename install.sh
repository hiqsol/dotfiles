#!/usr/bin/env bash
# install.sh — Idempotent dotfiles installer
# Run from anywhere. Assumes dotfiles repo is already cloned as ~/.config.
set -euo pipefail

DOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}"

# ── 1. Verify dotfiles repo is in place ─────────────────────────
if [ ! -d "$DOTDIR/git" ] || [ ! -f "$DOTDIR/fish/config.fish" ]; then
    echo "ERROR: dotfiles repo not found at $DOTDIR"
    echo "Clone first:  git clone git@github.com:hiqsol/dotfiles ~/.config"
    exit 1
fi

# ── 2. Home-directory symlinks ──────────────────────────────────
# Each entry: target (relative to $HOME) → source (relative to $DOTDIR)
declare -A LINKS=(
    [.aliases]="shell/.aliases"
    [.profile]="shell/.profile"
    [.shrc]="shell/.shrc"
    [.zshenv]="zsh/.zshenv"
    [.tmux.conf]="tmux/.tmux.conf"
    [bin]="bin"
)

echo "==> Creating home symlinks"
for name in "${!LINKS[@]}"; do
    target="$HOME/$name"
    source=".config/${LINKS[$name]}"
    if [ -L "$target" ]; then
        current=$(readlink "$target")
        if [ "$current" = "$source" ]; then
            echo "  ok  $name → $source"
            continue
        fi
        echo "  fix $name (was → $current)"
        rm "$target"
    elif [ -e "$target" ]; then
        echo "  SKIP $name — exists and is not a symlink (back up manually)"
        continue
    fi
    ln -s "$source" "$target"
    echo "  new $name → $source"
done

# ── 3. Fish shell — fisher + plugins ───────────────────────────
if command -v fish &>/dev/null; then
    echo "==> Setting up fish plugins"

    FISH_PLUGINS="$DOTDIR/fish/fish_plugins"
    FISHER="$DOTDIR/fish/functions/fisher.fish"

    # Install fisher if missing
    if [ ! -f "$FISHER" ]; then
        echo "  Installing fisher..."
        fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
    else
        echo "  ok  fisher already installed"
    fi

    # Install plugins from fish_plugins manifest
    if [ -f "$FISH_PLUGINS" ]; then
        echo "  Syncing plugins from fish_plugins..."
        fish -c "fisher update"
    fi
else
    echo "==> Fish not found, skipping plugin setup"
fi

echo "==> Done"

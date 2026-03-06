# Dotfiles

Personal dotfiles installed as `~/.config`. Symlinked from `~/prj/hiqsol/dotfiles`.

## Rules

- Both fish and zsh are active — alias/env changes must update both:
  - Fish: `fish/conf.d/aliases.fish`, `fish/config.fish`
  - Zsh/Bash: `shell/.aliases`, `shell/.shrc`, `shell/.shenv`
- Neovim uses LazyVim — plugins go in `lua/plugins/`, config in `lua/config/`.
- Tmux prefix is `Ctrl+Q`, not default `Ctrl+B`.
- Git config is at `git/config`, not `~/.gitconfig`.
- The `.gitignore` uses blacklist approach — only listed paths are ignored.
- Do not create files in directories managed by other applications.
- No build/test/lint commands at project level.

## Structure

- `shell/` — shared shell config (bash/zsh)
- `fish/` — fish shell config
- `zsh/` — zsh-specific config
- `nvim/` — neovim (LazyVim)
- `tmux/` — tmux
- `git/` — git config and ignore
- `bin/` — custom scripts
- `python/`, `pgsql/`, `ruff/`, `grc/`, `litecli/`, `regit/`, `wezterm/` — tool configs

# Dotfiles

Personal dotfiles installed as `~/.config`. Symlinked from `~/prj/hiqsol/dotfiles`.

## Rules

- Both fish and zsh are active — shell changes must update both:
  - Fish: `fish/conf.d/aliases.fish`, `fish/config.fish`
  - Zsh/Bash: `shell/.aliases`, `shell/.shrc`, `shell/.shenv`
- Neovim uses LazyVim — plugins go in `lua/plugins/`, config in `lua/config/`.
- Tmux prefix is `Ctrl+Q`, not default `Ctrl+B`.
- Git config is at `git/config`, not `~/.gitconfig`.
- In the process of moving to mise for tools installation.
- No build/test/lint commands at project level.

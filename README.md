# Dotfiles

Personal dotfiles. Sticking to defaults where possible.

## Setup

Two repos manage home environment:

- **hiqsol/dotfiles** (public, GitHub) — installed as `~/.config`,
  symlinked from `~/prj/hiqsol/dotfiles`
- **sol/home** (private, VDS) — installed as `/home/sol`,
  symlinked from `~/prj/sol/home`, manages home-level symlinks into `.config`

## Installation

Clone as `~/.config`:

```sh
git clone git@github.com:hiqsol/dotfiles ~/.config
```

Home symlinks (managed by sol/home):

```sh
ln -s .config/shell/.aliases ~/.aliases
ln -s .config/shell/.profile ~/.profile
ln -s .config/shell/.shrc ~/.shrc
ln -s .config/zsh/.zshenv ~/.zshenv
ln -s .config/tmux/.tmux.conf ~/.tmux.conf
ln -s .config/bin ~/bin
```

## What's included

| Directory  | Purpose                              |
|------------|--------------------------------------|
| `bin/`     | Custom scripts                       |
| `fish/`    | Fish shell config and aliases        |
| `git/`     | Git config and aliases               |
| `grc/`     | Generic colorizer patterns           |
| `litecli/` | Litecli config                       |
| `nvim/`    | Neovim (LazyVim) config and plugins  |
| `pgsql/`   | Psql prompt and settings             |
| `python/`  | Flake8, pylint, pypi configs         |
| `regit/`   | Regit config                         |
| `ruff/`    | Ruff formatter config                |
| `shell/`   | Shared shell aliases, profile, env   |
| `tmux/`    | Tmux config, prefix `Ctrl+Q`         |
| `wezterm/` | WezTerm terminal config              |
| `zsh/`     | Zsh config and functions             |

## Key choices

- Editor: `nvim`
- Shells: fish and zsh (both actively used)
- Tmux prefix: `Ctrl+Q`
- Git default branch: `master`

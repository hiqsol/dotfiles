# Dotfiles

Personal dotfiles for `~/.config`. Cloned directly into `~/.config` from GitHub `hiqsol/dotfiles`.

## Setup

```sh
git clone git@github.com:hiqsol/dotfiles ~/.config
# Home-level symlinks (~/.zshrc, etc.) are managed by sol/home repo
```

## Tools

- **Shells:** Fish & Zsh (primary, synchronized), Bash & Xonsh (best effort)
- **Prompt:** [Starship](https://starship.rs/) in fish, promptline in zsh (on purpose, to tell shells apart)
- **Package Manager:** [mise](https://mise.jdx.dev/) (runtimes & tools)
- **Editor:** Neovim (LazyVim)
- **Terminal:** WezTerm
- **Multiplexer:** Tmux (Prefix: `Ctrl+Q`)
- **Navigation:** [zoxide](https://github.com/ajeetdsouza/zoxide) (`z`)
- **Git UI:** [lazygit](https://github.com/jesseduffield/lazygit) (`lg`)
- **File Manager:** [yazi](https://yazi-rs.github.io/) (`y`)
- **System:** [bottom](https://github.com/ClementTsang/bottom) (`btm`)

## Tracking new stuff in `~/.config`

`.gitignore` is a **blacklist** on purpose: anything new that an app drops into
`~/.config` shows up in `git status` as untracked. That is the notification —
review it and either:

- track it (it's config worth keeping), or
- add it to `.gitignore` (app state, caches, machine-specific junk).

Don't switch to a whitelist (`/*` + `!/dir/`): it would silence these notices.

## Checks

- `mise run check` — lint everything (shellcheck, shfmt, fish/zsh/bash -n,
  stylua, taplo, rumdl, actionlint, gitleaks). Runs in CI too.
- `mise run doctor` — sanity-check the live setup (dead aliases, broken
  symlinks, stale mise shims).
- `mise run gen` — regenerate shell files from `shell/shell.toml`.
- After a fresh clone, enable the pre-commit hook:
  `git config core.hooksPath .githooks`

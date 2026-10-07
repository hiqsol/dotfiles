# Dotfiles

Personal dotfiles for `~/.config`. Cloned directly into `~/.config` from GitHub `hiqsol/dotfiles`.

## Bootstrap

```sh
git clone git@github.com:hiqsol/dotfiles ~/.config
~/.config/bin/install-apt console   # or desktop; add devtools for compilers
~/.config/bin/install-mise          # then everything else comes from mise:
~/.local/bin/mise install           # tools listed in mise/config.toml
git -C ~/.config config core.hooksPath .githooks
```

Home-level symlinks (`~/.zshenv`, `~/.profile`, `~/bin`, …) live in a separate
private home repo, together with private configs (`~/.ssh/config`, etc.).

## Tools

- **Shells:** Fish & Zsh (primary, synchronized), Bash & Xonsh (best effort)
- **Prompt:** [Starship](https://starship.rs/) in fish, promptline in zsh (on purpose, to tell shells apart)
- **Package Manager:** [mise](https://mise.jdx.dev/) (runtimes & tools, the
  only lazy installer)
- **Editor:** Neovim (LazyVim)
- **Terminal:** WezTerm, with its built-in multiplexer locally
- **Multiplexer:** Tmux on remote hosts (Prefix: `Ctrl+Q`)
- **Navigation:** [zoxide](https://github.com/ajeetdsouza/zoxide) (`z`)
- **Git UI:** [lazygit](https://github.com/jesseduffield/lazygit) (`lg`)
- **File Manager:** [yazi](https://yazi-rs.github.io/) (`y`)
- **System:** [bottom](https://github.com/ClementTsang/bottom) (`btm`),
  [dust](https://github.com/bootandy/dust)
- **Docs:** [tealdeer](https://github.com/tealdeer-rs/tealdeer) (`tldr`)
- **Pager/cat:** [bat](https://github.com/sharkdp/bat) (`cat`)

## Non-obvious layout

- Aliases and env vars for all shells live in `shell/shell.toml`; `mise run gen`
  turns it into the `*generated*` files (never edit those by hand).
- `mise/config.toml` holds globally installed tools; `.mise.toml` holds this
  repo's tasks.
- Git config is `git/config`, not `~/.gitconfig`.
- `etc/` holds system files to copy into `/etc` by hand.

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
- The pre-commit hook (enabled in Bootstrap) runs `scripts/check --staged`:
  fast checks on staged changes only. Bypass once with `git commit --no-verify`.

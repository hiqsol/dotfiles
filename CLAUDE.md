# Dotfiles

Personal dotfiles installed as `~/.config`. Cloned directly into `~/.config` from GitHub `hiqsol/dotfiles`.

## Rules

- Both fish and zsh are active — shell changes must update both.
- Simple aliases and env vars go in `shell/shell.toml`, then run
  `scripts/gen-shell` and commit the generated files (`*generated*`, never
  edit them by hand). `scripts/gen-shell --check` fails if they are stale.
- Commands that take arguments or need logic are POSIX `sh` scripts in `bin/`
  (on PATH in every shell), not shell functions.
- Per-shell files are only for logic (conditionals, PATH, tool init) and
  functions that must change the current shell (`cd`, `export`):
  - Fish: `fish/conf.d/aliases.fish`, `fish/config.fish`
  - Zsh/Bash: `shell/functions.sh`, `shell/.shrc`, `shell/.shenv`, `zsh/.zshrc`
  - Xonsh: `xonsh/rc.xsh`
- No lazy installers except `mise` (it installs everything else): add tools to
  `mise/config.toml` instead.
- Neovim uses LazyVim — plugins go in `lua/plugins/`, config in `lua/config/`.
- Tmux prefix is `Ctrl+Q`, not default `Ctrl+B`.
- Git config is at `git/config`, not `~/.gitconfig`.
- In the process of moving to mise for tools installation.
- Checks: `mise run check` (or `scripts/check`) before committing; `mise run doctor`
  for the live environment. Pre-commit hook: `git config core.hooksPath .githooks`
  (repo-local, never in `git/config`).
- Repo tasks live in `.mise.toml` only — `mise.toml`, `mise/config.toml` and
  `mise/tasks/` are global or apply to all of `~`. Task logic lives in `scripts/`.
- New linters: add to both `mise/config.toml` [tools] and the `check` task's
  `tools` in `.mise.toml` (CI uses the latter).

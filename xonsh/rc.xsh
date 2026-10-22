import os
from xonsh.built_ins import XSH

# Simple env vars, PATH and aliases live in ~/.config/shell/shell.toml,
# run scripts/gen-shell after editing.
source ~/.config/xonsh/generated.xsh

$ls_options = '--color' if os.uname().sysname == 'Linux' else ''

# Mise activation
execx($(~/.local/bin/mise activate xonsh))

# Modern tools - they should be in the PATH now via shims
execx($(starship init xonsh))
execx($(zoxide init xonsh))

# xonsh 0.11 defaults $XONSH_HISTORY_FILE to None; on gc/merge that gets
# stringified and it writes "./None" in the CWD. Pin it to a real path.
$XONSH_HISTORY_FILE = $HOME + '/.local/share/xonsh/history_json/xonsh-history.json'

# Aliases - simple ones can be strings
aliases['la'] = 'ls -laFh ' + $ls_options
aliases['lh'] = 'ls -lFh ' + $ls_options

# Functions that change shell state; the rest are scripts in ~/.config/bin
def _md(args):
    if not args: return
    os.makedirs(args[0], exist_ok=True)
    os.chdir(args[0])

aliases['md'] = _md

# Xonsh specific settings
$UPDATE_OS_ENVIRON = True
$XONSH_SHOW_TRACEBACK = True
$COMPLETIONS_CONFIRM = True

# SSH agent logic (initial sync)
sock = f"/home/{os.environ.get('USER')}/.ssh/ssh-agent.sock"
if os.environ.get('SSH_AUTH_SOCK') and os.environ.get('SSH_AUTH_SOCK') != sock and os.path.exists(os.environ.get('SSH_AUTH_SOCK')):
    if os.path.islink(sock):
        os.unlink(sock)
    os.symlink(os.environ.get('SSH_AUTH_SOCK'), sock)
os.environ['SSH_AUTH_SOCK'] = sock

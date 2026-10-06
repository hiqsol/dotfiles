import os
import subprocess
import glob
import pwd
from xonsh.built_ins import XSH

# PATH - initialize with shims for mise tools to be found immediately
for _p in reversed([
    $HOME + '/.local/share/mise/shims',
    $HOME + '/sbin',
    $HOME + '/bin',
    $HOME + '/.config/composer/vendor/bin',
    $HOME + '/.local/bin',
    $HOME + '/go/bin',
    '/usr/local/go/bin',
]):
    $PATH.insert(0, _p)
del _p

# Project-local bins go LAST so an untrusted repo cannot shadow system commands.
# Drop any copies inherited from a parent shell first, then append.
for _p in ['./vendor/bin', './node_modules/.bin']:
    while _p in $PATH:
        $PATH.remove(_p)
    $PATH.append(_p)
del _p

# Simple env vars and aliases live in ~/.config/shell/shell.toml,
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

# Direnv for xonsh usually requires xontrib
# If it's not installed, we can try to fall back to the direnv hook if it ever supports it
# but for now we'll just try to load the xontrib if it exists
try:
    xontrib load direnv
except Exception:
    pass

# Aliases - simple ones can be strings
aliases['la'] = 'ls -laFh ' + $ls_options
aliases['lh'] = 'ls -lFh ' + $ls_options

# Functions that change shell state; the rest are scripts in ~/.config/bin
def _reset_ssh_agent():
    user = os.environ.get('USER')
    sock_link = f"/home/{user}/.ssh/ssh-agent.sock"
    for sock in glob.glob('/tmp/agent.*'):
        try:
            stat = os.stat(sock)
            if pwd.getpwuid(stat.st_uid).pw_name == user:
                os.environ['SSH_AUTH_SOCK'] = sock
                if subprocess.run(['ssh-add', '-l'], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL).returncode == 0:
                    print(f"Agent link changed to {sock}")
                    if os.path.islink(sock_link):
                        os.unlink(sock_link)
                    os.symlink(sock, sock_link)
                    os.environ['SSH_AUTH_SOCK'] = sock_link
                    return True
        except Exception:
            pass
    return False

def _md(args):
    if not args: return
    os.makedirs(args[0], exist_ok=True)
    os.chdir(args[0])

aliases['reset_ssh_agent'] = _reset_ssh_agent
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

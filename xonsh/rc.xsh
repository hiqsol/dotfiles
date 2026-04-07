import os
import subprocess
import glob
import pwd
from xonsh.built_ins import XSH

# PATH - initialize with shims for mise tools to be found immediately
$PATH.insert(0, $HOME + '/.local/share/mise/shims')
$PATH.insert(0, './vendor/bin')
$PATH.insert(0, './node_modules/.bin')
$PATH.insert(0, $HOME + '/sbin')
$PATH.insert(0, $HOME + '/bin')
$PATH.insert(0, $HOME + '/.config/composer/vendor/bin')
$PATH.insert(0, $HOME + '/.local/bin')
$PATH.insert(0, $HOME + '/go/bin')
$PATH.insert(0, '/usr/local/go/bin')

# Environment variables
$EDITOR = 'nvim'
$VISUAL = 'nvim'
$PAGER = 'less -S'
$BROWSER = 'local-open'
$LANG = 'en_US.UTF-8'
$LC_ALL = 'en_US.UTF-8'
$ls_options = '--color' if os.uname().sysname == 'Linux' else ''

# Mise activation
execx($(~/.local/bin/mise activate xonsh))

# Modern tools - they should be in the PATH now via shims
execx($(starship init xonsh))
execx($(zoxide init xonsh))

# Atuin support
try:
    execx($(atuin init xonsh))
except Exception:
    pass

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
aliases['ll'] = 'eza -lAh'
aliases['l'] = 'eza -la'
aliases['ls'] = 'eza'

aliases['a'] = 'boxer abstract'
aliases['c'] = 'boxer claude'
aliases['d'] = 'docker'
aliases['dc'] = 'docker compose'
aliases['g'] = 'git'
aliases['ga'] = 'gita'
aliases['gt'] = 'ga ll'
aliases['gtree'] = 'eza -laT --git-ignore --git -I ".git|node_modules|vendor" ~/prj'
aliases['s'] = 'ssh'
aliases['v'] = 'nvim'
aliases['y'] = 'yazi'
aliases['lg'] = 'lazygit'
aliases['rga'] = 'ripgrep-all'
aliases['gm'] = 'gemini'

aliases['dco'] = 'dcomposer'
aliases['gr'] = 'rg --no-heading'
aliases['f'] = '~/prj/instockcom/ferroctl/ferroctl'
aliases['lt'] = 'eza -laT -I .git'
aliases['cdd'] = 'cd ~/.config'
aliases['cdm'] = 'cd ~/prj/hiqsol/nanokai/home/kai/memory'
aliases['cdq'] = 'cd ~/prj/hiqsol/quotes'
aliases['grab'] = 'g grab'
aliases['lgrab'] = 'g lgrab'
aliases['upgrade'] = 'sudo apt update && sudo apt upgrade'
aliases['upall'] = '~/.local/bin/mise self-update && ~/.local/bin/mise upgrade && upgrade'

# Custom functions (cdp, cdo, cdc)
def _dcomposer(args):
    ssh_auth_sock = os.environ.get('SSH_AUTH_SOCK', '')
    cmd = [
        "docker", "compose", "run", "--rm",
        "-v", f"{ssh_auth_sock}:/ssh-agent",
        "-e", "SSH_AUTH_SOCK=/ssh-agent",
        "php-fpm", "sh", "-c",
        f"git config --global --add safe.directory /app && composer {' '.join(args)}"
    ]
    subprocess.run(cmd)

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

def _drun(args):
    cmd = ["docker", "run", "-it", "--rm", "-v", f"{os.environ['HOME']}:{os.environ['HOME']}", "-w", os.getcwd()] + args
    subprocess.run(cmd)

def _dbash(args):
    if not args: return
    cmd = ["docker", "exec", "-it", args[0], "bash", "-c", f"stty cols {os.environ.get('COLUMNS', 80)} rows {os.environ.get('LINES', 24)} && bash"]
    subprocess.run(cmd)

def _md(args):
    if not args: return
    os.makedirs(args[0], exist_ok=True)
    os.chdir(args[0])

aliases['dcomposer'] = _dcomposer
aliases['reset_ssh_agent'] = _reset_ssh_agent
aliases['drun'] = _drun
aliases['dbash'] = _dbash
aliases['dphp84'] = lambda args: _drun(["hiqdev/php:8.4-cli-alpine", "php"] + args)
aliases['md'] = _md

# Navigational aliases
aliases[','] = 'cd ..'
aliases[',,'] = 'cd ../..'
aliases[',,,'] = 'cd ../../..'
aliases[',,,,'] = 'cd ../../../..'
aliases[',,,,,'] = 'cd ../../../../..'
aliases[',,,,,,'] = 'cd ../../../../../..'

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

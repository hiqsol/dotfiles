#! /usr/local/bin/zsh

source ~/.shrc
source ~/.aliases

### zsh-only aliases (global and nocorrect); shared ones are in ~/.config/shell/shell.toml
alias -g G='| rg'
alias -g H='| head'
alias -g L='| less'
alias -g R='| less -R'
alias -g W='| wc'

alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias git='nocorrect git'
alias mkdir='nocorrect mkdir -p'

source ~/.config/zsh/keys.zsh
[[ -s /etc/grc.zsh ]] && source /etc/grc.zsh  # grc colouring (fish mirrors this list)

### AUTOLOADS
fpath=(~/.config/zsh/completion $fpath)
autoload -U colors compinit promptinit zfinit zcalc edit-command-line select-word-style
zle -N edit-command-line

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

autoload -Uz bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

colors;compinit -i;promptinit;zfinit
select-word-style bash

### DIFFERENT OPTIONS
setopt AUTO_CD CDABLE_VARS
setopt MULTIOS ### multi redirection: echo > 1 > 2
setopt CORRECT AUTO_MENU EXTENDED_GLOB

### COMPLETION
# Allow key-driven interface, highlight active option
zstyle ':completion:*' menu select=1 _complete _ignored _approximate
# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ~/.config/zsh/cache/
# Remove 'proxy' completion
zstyle ':completion:*:cd:*' tag-order local-directories path-directories

### HISTORY
HISTFILE=~/.config/zsh/.history
HISTSIZE=100000
SAVEHIST=100000
setopt SHARE_HISTORY APPEND_HISTORY INC_APPEND_HISTORY
setopt HIST_NO_STORE HIST_IGNORE_SPACE HIST_REDUCE_BLANKS HIST_VERIFY
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_SAVE_NO_DUPS HIST_FIND_NO_DUPS HIST_EXPIRE_DUPS_FIRST

### PROMPT
ZLE_RPROMPT_INDENT=0
# keep promptline in zsh on purpose: a different prompt than fish/starship
# makes it obvious which shell is running, so starship is not used in zsh
source ~/.config/zsh/git_status.sh
source ~/.config/zsh/promptline.sh

### PLUGINS
plugins=(
    ~/.fzf.zsh
    ~/.vim/plugged/zsh-autosuggestions/zsh-autosuggestions.zsh
    ~/.config/zsh/local.sh
)

for file in $plugins; do
    if [ -f $file ]; then
        source $file
    fi
done

if [[ -x ~/.local/bin/mise ]]; then
    eval "$(~/.local/bin/mise activate zsh)"
else
    # lazy installer: the only one, mise brings everything else
    mise() { ~/.config/bin/install-mise && ~/.local/bin/mise "$@" }
fi
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

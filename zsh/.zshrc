#! /usr/local/bin/zsh

source ~/.shrc
source ~/.aliases
source ~/.config/zsh/keys.zsh
source ~/.config/zsh/console.sh
source ~/.config/zsh/desktop.sh
source ~/.config/zsh/functions.sh

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
source ~/.config/zsh/git_status.sh
source ~/.config/zsh/promptline.sh

### PLUGINS
plugins=(
    ~/.fzf.zsh
    ~/.vim/plugged/zsh-autosuggestions/zsh-autosuggestions.zsh
    ~/.config/zsh/local.sh
    ~/.config/nvm/nvm.sh
)

for file in $plugins; do
    if [ -f $file ]; then
        source $file
    fi
done

eval "$(~/.local/bin/mise activate zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(atuin init zsh)"

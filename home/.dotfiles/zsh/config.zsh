export LC_ALL=en_US.UTF-8
export LSCOLORS="exfxcxdxbxegedabagacad"
export CLICOLOR=1

export EDITOR="vim"

setopt histignoredups
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

set -o emacs

bindkey '^R' history-incremental-search-backward
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

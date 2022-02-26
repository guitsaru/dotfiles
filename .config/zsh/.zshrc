source $ZDOTDIR/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $ZDOTDIR/zsh-completions/zsh-completions.plugin.zsh
source $ZDOTDIR/zsh-history-substring-search/zsh-history-substring-search.zsh

export SHELL_SESSION_DIR="$XDG_STATE_HOME/zsh/sessions"
export SHELL_SESSION_FILE="$SHELL_SESSION_DIR/$TERM_SESSION_ID"
export HISTFILE="$XDG_STATE_HOME/zsh/history"
mkdir -p "$XDG_STATE_HOME/zsh"
touch $HISTFILE
mkdir -p $SHELL_SESSION_DIR

export EDITOR="nvim"
export PATH=$PATH:~/.local/bin
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export HISTTIMEFORMAT="[%F %T]"
export SAVEHIST=100000000

setopt EXTENDED_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

alias dotfiles='/usr/bin/git --git-dir=$HOME/code/.dotfiles/ --work-tree=$HOME'

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

if [[ -d $HOME/.asdf/ ]]; then
  source $HOME/.asdf/asdf.sh
  # append completions to fpath
  fpath=(${ASDF_DIR}/completions $fpath)
fi

# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

if ! command -v starship &> /dev/null; then
  sh -c "$(curl -fsSL https://starship.rs/install.sh)" -- -f
  export PS1='$(ssh_status)%{$fg_bold[red]%}%C%{$reset_color%} $(git_prompt)→ '
fi

eval "$(starship init zsh)"


export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:=${HOME}/.config}
export XDG_STATE_HOME=${XDG_STATE_HOME:="$HOME/.local/state"}
export ZDOTDIR=${ZDOTDIR:="$XDG_CONFIG_HOME/zsh"}

source $ZDOTDIR/.zshenv

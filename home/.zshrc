# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

export NVM_DIR="/Users/mattpruitt/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[ -s "$ZSH/system/path.zsh" ] && source $ZSH/system/path.zsh

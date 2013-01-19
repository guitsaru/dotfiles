# shortcut to this dotfiles path is $ZSH
export ZSH=$HOME/.dotfiles

for config_file ($ZSH/**/*.zsh) source $config_file

if [[ -a ~/.`whoami`.zsh ]]
then
  source ~/.`whoami`.zsh
fi

# initialize autocomplete here, otherwise functions won't be loaded
autoload -U compinit
compinit

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

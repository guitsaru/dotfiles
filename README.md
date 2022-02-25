```sh
git clone --bare https://github.com/guitsaru/dotfiles.git $HOME/code/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/code/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout
```

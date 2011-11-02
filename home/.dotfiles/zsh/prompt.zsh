setopt prompt_subst
autoload colors && colors

git_branch() {
  echo "%{$fg_bold[yellow]%}$(git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})%{$reset_color%}"
}

# Show character if changes are pending
git_status() {
  if current_git_status=$(git status | grep 'working directory clean' 2> /dev/null); then
    echo ""
  else;
    echo "%{$fg_no_bold[red]%}*%{$reset_color%}"
  fi
}

git_prompt() {
  ref=$(git symbolic-ref HEAD 2> /dev/null)
  if [[ -n $ref ]]; then
    echo "[$(git_branch)$(git_status)] "
  fi
}

rvm_prompt(){
  if $(which rvm &> /dev/null)
  then
    echo "(%{$fg_bold[yellow]%}$(rvm tools identifier)%{$reset_color%}) "
  else
    echo ""
  fi
}


export PS1='%{$fg_bold[red]%}%C%{$reset_color%} $(git_prompt)→ '

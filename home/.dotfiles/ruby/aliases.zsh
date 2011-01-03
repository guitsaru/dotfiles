alias migrate="rake db:migrate db:test:prepare"

alias r="rails"

function dev {
  tmux start-server
  tmux new-session -d -s Rails -n work
  tmux new-window -tRails:1 -n server
  tmux new-window -tRails:2 -n test

  tmux send-keys -tRails:1 'ss' C-m
  tmux send-keys -tRails:2 'watchr specs.watchr' C-m
  tmux select-window -tRails:0

  tmux attach-session -d -tRails
}

function ss {
  if [ -e script/rails ]; then
    script/rails server $@
  else
    script/server $@
  fi
}

function sc {
  if [ -e script/rails ]; then
    script/rails console $@
  else
    script/console $@
  fi
}

function sg {
  if [ -e script/rails ]; then
    script/rails generate $@
  else
    script/generate $@
  fi
}

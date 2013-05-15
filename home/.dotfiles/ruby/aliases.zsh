alias migrate="rake db:migrate db:test:prepare"

function ss {
  if [ -e script/rails ]; then
    script/rails server $@
  elif [ -e bin/rails ]; then
    bin/rails server $@
  else
    script/server $@
  fi
}

function sc {
  if [ -e script/rails ]; then
    script/rails console $@
  elif [ -e bin/rails ]; then
    bin/rails console $@
  else
    script/console $@
  fi
}

function sg {
  if [ -e script/rails ]; then
    script/rails generate $@
  elif [ -e bin/rails ]; then
    bin/rails generate $@
  else
    script/generate $@
  fi
}

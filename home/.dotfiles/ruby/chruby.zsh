if [[ -e /usr/local/share/chruby ]]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh

  [[ -r ~/.ruby-version ]] && chruby $(cat ~/.ruby-version)
  [[ -r ./.ruby-version ]] && chruby $(cat ./.ruby-version)
fi

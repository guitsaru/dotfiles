[[ -r /opt/boxen/env.d/rbenv.sh ]] && rm /opt/boxen/env.d/rbenv.sh

if [[ -e /usr/local/share/chruby ]]; then
  source /usr/local/share/chruby/chruby.sh
  source /usr/local/share/chruby/auto.sh

  [[ -r ~/.ruby-version ]] && chruby $(cat ~/.ruby-version)
  [[ -r ./.ruby-version ]] && chruby $(cat ./.ruby-version)
fi

if [[ -e /opt/boxen/homebrew/share/chruby ]]; then
  source /opt/boxen/homebrew/share/chruby/chruby.sh
  source /opt/boxen/homebrew/share/chruby/auto.sh

  [[ -r ~/.ruby-version ]] && chruby $(cat ~/.ruby-version)
  [[ -r ./.ruby-version ]] && chruby $(cat ./.ruby-version)
fi

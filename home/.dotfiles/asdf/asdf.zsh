#!/usr/bin/env bash

if [ -d "$HOME/.asdf" ]; then
  . $HOME/.asdf/asdf.sh
fi

if [ -d "/usr/local/opt/asdf" ]; then
  . /usr/local/opt/asdf/asdf.sh
fi

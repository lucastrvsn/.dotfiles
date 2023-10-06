#!/usr/bin/env bash

if [ ! "$(uname)" == "Darwin" ]; then
  exit 0
fi

DIR="$PWD/$(dirname "$0")"

if test ! $(which brew); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew bundle --no-upgrade --no-lock --quiet --file="$DIR/Brewfile"

# source "$PWD/mac.sh"

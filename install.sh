#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

# Folders that must exist as real directories before stow runs; a missing one
# gets folded into a single link back into this repo.
mkdir -p "$HOME/Projects" "$HOME/.config"

# homebrew and the Brewfile packages (stow included)
if [ "$(uname)" == "Darwin" ]; then
  if [ ! -x /opt/homebrew/bin/brew ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  eval "$(/opt/homebrew/bin/brew shellenv)"
  brew bundle --no-upgrade --quiet --file=Brewfile
fi

# run prepare scripts, if any inside packages
for f in */prepare.sh; do
  "./$f"
done

# stow packages (stow first: its global ignore applies to the rest)
stow -v stow
stow -v agents
stow -v ghostty
stow -v git
stow -v gitui
stow -v gnupg
stow -v nvim
stow -v opencode
stow -v zsh

# run install scripts, if any inside packages
# for f in */install.sh; do
#   $f
# done

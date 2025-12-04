#!/usr/bin/env bash

# creates my default folder for projects, if it doesn't exists yet
if [ ! -d "$HOME/Projects" ]; then
  mkdir -p $HOME/Projects
fi

# run prepare scripts, if any inside packages
for f in */prepare.sh; do
  $f
done

# stow packages
stow -v asdf
stow -v ghostty
stow -v git
stow -v gitui
stow -v gnupg
stow -v nvim
stow -v starship
stow -v zsh

# run install scripts, if any inside packages
# for f in */install.sh; do
#   $f
# done

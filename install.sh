#!/usr/bin/env bash

# creates my default folder for projects, if not exists yet
if [ ! -d "$HOME/Projects" ]; then
  mkdir -p $HOME/Projects
fi

# run prepare scripts, if any inside packages
for f in */prepare.sh; do
	$f
done

# stow packages
stow -v asdf
stow -v git
stow -v gitui
stow -v gnupg
stow -v nvim
stow -v starship
stow -v tmux
stow -v wezterm
stow -v zsh

# run install scripts, if any inside packages
# for f in */install.sh; do
# 	$f
# done

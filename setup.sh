#!/usr/bin/env bash

# remove any existing config files if needed
rm -rf $HOME/.config/alacritty
rm -rf $HOME/.config/nvim
rm -rf $HOME/.config/zsh
rm -rf $HOME/.gitconfig
rm -rf $HOME/.gitignoreglobal
rm -rf $HOME/.gitmessage
rm -rf $HOME/.tmux.conf
rm -rf $HOME/.zprofile
rm -rf $HOME/.zshrc

# symlinking dotfiles to home directory
(
  mkdir -p "$HOME/.config"

  # zsh
  ln -sf "$PWD/zsh/zshrc" "$HOME/.zshrc"
  ln -sf "$PWD/zsh/zprofile" "$HOME/.zprofile"
  ln -sf "$PWD/zsh" "$HOME/.config/zsh"

  # tmux
  ln -sf "$PWD/tmux/config" "$HOME/.tmux.conf"

  # git
  ln -sf "$PWD/git/gitconfig" "$HOME/.gitconfig"
  ln -sf "$PWD/git/gitignore" "$HOME/.gitignoreglobal"
  ln -sf "$PWD/git/gitmessage" "$HOME/.gitmessage"

  # neovim
  ln -sf "$PWD/nvim" "$HOME/.config/nvim"

  # alacritty
  ln -sf "$PWD/alacritty" "$HOME/.config/alacritty"
)

# creates my default folder for projects
mkdir -p $HOME/Projects

if [ "$(uname)" == "Darwin" ]; then
  # install homebrew
  if test ! $(which brew); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  # install homebrew bundle located at Brewfile
  brew bundle --file --no-lock "$PWD/Brewfile"

  # set my macOS preferences
  source $PWD/mac.sh
fi


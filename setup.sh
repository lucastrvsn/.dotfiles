#!/usr/bin/env bash

# creates my default folder for projects if not exists yet
if [ ! -d "$HOME/Projects" ]; then
  mkdir -p $HOME/Projects
fi

# remove any existing config files if needed
rm -rf $HOME/.config/alacritty
rm -rf $HOME/.config/nvim
rm -rf $HOME/.config/zsh
rm -rf $HOME/.config/.starship.toml
rm -rf $HOME/.gitconfig
rm -rf $HOME/.gitignoreglobal
rm -rf $HOME/.gitmessage
rm -rf $HOME/.tmux.conf
rm -rf $HOME/.tmux
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

  # starship
  ln -sf "$PWD/starship/config.toml" "$HOME/.config/starship.toml"

  # git
  ln -sf "$PWD/git/gitconfig" "$HOME/.gitconfig"
  ln -sf "$PWD/git/gitignore" "$HOME/.gitignoreglobal"
  ln -sf "$PWD/git/gitmessage" "$HOME/.gitmessage"

  # neovim
  ln -sf "$PWD/nvim" "$HOME/.config/nvim"

  # alacritty
  ln -sf "$PWD/alacritty" "$HOME/.config/alacritty"
)

# install tmux plugin manager (tpm)
# https://github.com/tmux-plugins/tpm/
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  /bin/bash -c "$(git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm)"
fi

# install packer.nvim (neovim plugin manager)
# https://github.com/wbthomason/packer.nvim/
if [ ! -d "$HOME/.local/share/nvim/site/pack/packer" ]; then
  /bin/bash -c "$(git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim)"
fi

if [ "$(uname)" == "Darwin" ]; then
  # install homebrew
  # https://brew.sh/
  if test ! $(which brew); then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
  fi

  # install homebrew bundle located at Brewfile
  brew bundle --file="$PWD/Brewfile"

  # set my macOS preferences
  source $PWD/mac.sh
fi


#! /bin/bash

current_dir=$(pwd)

function font_config() {
  echo "configuring font config..."
  mkdir -p ~/.config/fontconfig
  cat > ~/.config/fontconfig/fonts.conf << EOL
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <alias>
   <family>sans-serif</family>
   <prefer>
     <family>Noto Sans</family>
     <family>Noto Color Emoji</family>
     <family>Noto Emoji</family>
   </prefer>
  </alias>
  <alias>
   <family>serif</family>
   <prefer>
     <family>Noto Serif</family>
     <family>Noto Color Emoji</family>
     <family>Noto Emoji</family>
   </prefer>
  </alias>
  <alias>
  <family>monospace</family>
  <prefer>
    <family>Noto Mono</family>
    <family>Noto Color Emoji</family>
    <family>Noto Emoji</family>
   </prefer>
  </alias>
</fontconfig>
EOL
}

function yay() {
  echo "installing yay..."
  git clone https://aur.archlinux.org/yay.git ~/yay
  cd ~/yay
  makepkg -si

  # clean yay build directory
  cd $current_dir
  rm -rf ~/yay
}

function starship() {
  curl -fsSL https://starship.rs/install.sh | bash
}

function zplug() {
  echo "installing zplug..."
  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
}

function vim_plug() {
  echo "installing vim-plug..."
  curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

function asdf() {
  echo "installing asdf..."
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  cd ~/.asdf
  git checkout "$(git describe --abbrev=0 --tags)"
}

function cp_config_file() {
  echo "copying config files..."
  cd $current_dir
  cd ..
  cp -rfv .{zshrc,tmux.conf} ~
  cp -rfv .config/{kitty,nvim} ~/.config
  cp -rfv .config/starship.toml ~/.config
}

font_config
yay
starship
zplug
vim_plug
asdf
cp_config_file

echo "everything is good, enjoy! :)"

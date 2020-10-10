#! /bin/bash

# configure fonts
echo "configuring font config"
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

# install yay
git clone https://aur.archlinux.org/yay.git ~
cd ~/yay
makepkg -si

# install packages from aur using yay
PACKAGES=(
  libpipewire02
  xdg-desktop-portal-wlr
  # theme
  # pop-gtk-theme-bin
  # pop-icon-theme-git
  xcursor-openzone
  # misc
  light
  playerctl
  ffmpeg
  starship-bin
  # wl-clipboard
  xclip
  xsel
  # apps
  nnn
  neovim-nightly
)
yay -S ${PACKAGES[@]}
yay -Yc

# clean yay build directory
rm -rf ~/yay
cd ~

echo "all packages has been installed."

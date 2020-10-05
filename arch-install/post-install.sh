#! /bin/bash

# configure fonts
mkdir -p ~/.config/fontconfig
cp -rfv ./fontconfig.conf ~/.config/fontconfig/fonts.conf

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# install packages using yay
PACKAGES=(
  # wm
  sway
  swayidle
  waybar
  wofi
  kanshi
  mako
  xwayland
  libpipewire02
  xdg-desktop-portal-wlr
  # login manager
  lightdm
  lightdm-gtk-greeter
  # misc
  playerctl
  waybar
  grim
  slurp
  swappy
  ffmpeg
  rsync
  archivemount
  starship-bin
  wl-clipboard
  # apps
  alacritty
  nnn
  neovim-nightly
  feh
)
yay -S ${PACKAGES[@]}

# setup services
systemctl enable lightdm.service

# clean temp dirs
rm -rf yay

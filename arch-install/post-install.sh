#! /bin/bash

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --asroot
rm -rf yay

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
)
yay -S ${PACKAGES[@]}

# setup services
systemctl enable lightdm.service

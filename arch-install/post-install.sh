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

# configure theme
echo "configuring theme config"
mkdir -p ~/.config/gtk-3.0
cat > ~/.config/gtk-3.0/settings.ini << EOL
[Settings]
gtk-application-prefer-dark-theme=1
gtk-theme-name=Pop-dark
gtk-icon-theme-name=Pop
gtk-font-name=Noto Sans 11
gtk-cursor-theme-name=OpenZone_White
gtk-cursor-theme-size=24
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle=hintfull
EOL

# install yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# install packages from aur using yay
PACKAGES=(
  # wm
  waybar
  wofi
  kanshi
  mako
  libpipewire02
  xdg-desktop-portal-wlr
  # theme
  pop-gtk-theme
  pop-icon-theme-git
  xcursor-openzone
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
yay -Yc

# clean yay build directory
rm -rf yay

echo "all packages has been installed."

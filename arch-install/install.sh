#! /bin/bash

# This script is based on krushn's script
# https://github.com/krushndayshmookh/krushn-arch

# filesystem mounting
echo "This script will create and format the partitions as follows:"
echo "/dev/sda1 - 512Mib will be mounted as /efi"
echo "/dev/sda2 - 8GiB will be used as swap"
echo "/dev/sda3 - rest of space will be mounted as /"
read -p 'Continue? [y/N]: ' fsok
if ! [ $fsok = 'y' ] && ! [ $fsok = 'Y' ]
then
  echo "Edit the script to continue..."
  exit
fi

sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk /dev/sda
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk 
  +512M # 512 MB boot parttion
  n # new partition
  p # primary partition
  2 # partion number 2
    # default, start immediately after preceding partition
  +8G # 8 GB swap parttion
  n # new partition
  p # primary partition
  3 # partion number 3
    # default, start immediately after preceding partition
    # default, extend partition to end of disk
  a # make a partition bootable
  1 # bootable partition is partition 1 -- /dev/sda1
  p # print the in-memory partition table
  w # write the partition table
  q # and we're done
EOF

# Format the partitions
mkfs.ext4 /dev/sda3
mkfs.fat -F32 /dev/sda1

# setup time
timedatectl set-ntp true

# mount the partitions
mount /dev/sda3 /mnt
mkdir -pv /mnt/efi
mount /dev/sda1 /mnt/efi
mkswap /dev/sda2
swapon /dev/sda2

# pacman
pacman -Sy
pacman -S --noconfirm --needed --noprogressbar --quiet reflector
reflector --protocol https --country "Brazil" --country "United States" --age 24 --sort rate --save /etc/pacman.d/mirrorlist

# arch install
echo "starting arch install..."

PACKAGES=(
  base
  base-devel
  linux
  linux-firmware
  grub
  efibootmgr
  intel-ucode
  mesa
  alsa-oss
  alsa-lib
  alsa-utils
  pulseaudio
  sudo
  openssh
  openvpn
  git
  curl
  ripgrep
  zsh
  tmux
  fzf
  kitty
  playerctl
  libpipewire02
  xdg-user-dirs
  xdg-utils
  xdg-desktop-portal-wlr
  noto-fonts
  noto-fonts-emoji
  noto-fonts-cjk
  ttf-jetbrains-mono
)

# codec and other media packages
PACKAGES+=(
  ffmpeg
  exfat-utils
  fuse-exfat
  a52dec
  faac
  faad2
  flac
  jasper
  lame
  libdca
  libdv
  libmad
  libmpeg2
  libtheora
  libvorbis
  libxv
  wavpack
  x264
  x265
  xvidcore
  gstreamer
  gst-libav
  gst-plugins-good
)

# disc and archive packages
PACKAGES+=(
  tar
  gzip
  unzip
  unrar
  rsync
  gvfs
  ntfs-3g
  gvfs-afc
)

echo "install laptop utils?"
read -p 'y/N: ' de
if ! [ $de = 'y' ] && ! [ $de = 'Y' ]
then
  PACKAGES+=(
    bluez
    bluez-utils
    tlp
    light
    iwd
    wpa_supplicant
    dialog
    libinput
  )
fi

echo "choose what do you want to install"
read -p 'gnome (g), budgie (b), sway (s), awesome (a), xfce (x) or mate (m)? ' de
if [ $de = 'g' ] || [ $de = 'G' ]
then
  PACKAGES+=(
    gnome
    gnome-extra
    gdm
    wl-clipboard
  )
if [ $de = 'b' ] || [ $de = 'B' ]
then
  PACKAGES+=(
    gnome
    budgie-desktop
    budgie-extras
    gdm
  )
elif [ $de = 's' ] || [ $de = 'S' ]
then
  PACKAGES+=(
    sway
    swayidle
    swaylock
    connman
    alacritty
    wofi
    wl-clipboard
    xorg-server-xwayland
  )
elif [ $de = 'a' ] || [ $de = 'A' ]
then
  PACKAGES+=(
    xorg
    awesome
    connman
  )
elif [ $de = 'x' ] || [ $de = 'X' ]
then
  PACKAGES+=(
    xorg
    xfce4
    xfce4-goodies
    network-manager-applet
    lightdm
    lightdm-gtk-greeter
  )
elif [ $de = 'm' ] || [ $de = 'M' ]
then
  PACKAGES+=(
    xorg
    mate
    mate-extra
    mate-media
    blueman
    mate-power-manager
    system-config-printer
    network-manager-applet
    lightdm
    lightdm-gtk-greeter
  )
fi

pacstrap /mnt ${PACKAGES[@]}

# fstab
genfstab -U /mnt >> /mnt/etc/fstab

# copy post-install script
cp -rfv ./chroot-install.sh /mnt/chroot-install.sh
chmod a+x /mnt/chroot-install.sh

# copy the updated mirrorlist to the installed system
cp -rfv /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist

# chroot
echo "Running chroot-install.sh script on newly installed OS."
arch-chroot /mnt ./chroot-install.sh
rm /mnt/chroot-install.sh

# ready to go arch
echo "If chroot-install.sh was run succesfully, you will now have a fully working bootable Arch Linux system installed."
echo "The only thing left is to reboot into the new system."
echo "Press any key to reboot or Ctrl+C to cancel..."
read tmpvar
reboot

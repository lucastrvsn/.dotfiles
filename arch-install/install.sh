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
reflector -l 12 --sort rate --save /etc/pacman.d/mirrorlist

# arch install
echo "starting arch install..."

PACKAGES=(
  # base
  base
  base-devel
  linux
  linux-firmware
  grub
  efibootmgr
  intel-ucode
  zsh
  mesa
  pulseaudio
  sudo
  # network, bluetooth, touchpad
  networkmanager
  iw
  wpa_supplicant
  dialog
  network-manager-applet
  networkmanager-openvpn
  bluez-utils
  libinput
  # misc
  gnome-power-manager
  zsh
  git
  curl
  ripgrep
  xdg-user-dirs
  # display
  sway
  swaylock
  swayidle
  lightdm
  lightdm-gtk-greeter
  xorg-server
  xorg-server-xwayland
  # fonts
  fontconfig
  freetype2
  noto-fonts
  noto-fonts-emoji
)
pacstrap /mnt ${PACKAGES[@]}

# fstab
genfstab -U /mnt >> /mnt/etc/fstab

# copy post-install script
cp -rfv ./chroot-install.sh /mnt/chroot-install.sh
cp -rfv ./fontconfig.conf /mnt/fontconfig.conf
chmod a+x /mnt/chroot-install.sh

# copy the updated mirrorlist to the installed os
cp -rfv /etc/pacman.d/mirrorlist /mnt/etc/pacman.d/mirrorlist

# chroot
echo "After chrooting into newly installed OS, please run the chroot-install.sh by executing ./chroot-install.sh"
echo "Press any key to chroot..."
read tmpvar
arch-chroot /mnt

# delete chroot-install
rm /mnt/chroot-install.sh

# ready to go arch
echo "If chroot-install.sh was run succesfully, you will now have a fully working bootable Arch Linux system installed."
echo "The only thing left is to reboot into the new system."
echo "Press any key to reboot or Ctrl+C to cancel..."
read tmpvar
reboot

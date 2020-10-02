#! /bin/bash

# This script is based on krushn's script
# https://github.com/krushndayshmookh/krushn-arch

# filesystem mounting
echo "This script will create and format the partitions as follows:"
echo "/dev/sda1 - 512Mib will be mounted as /boot/efi"
echo "/dev/sda2 - 8GiB will be used as swap"
echo "/dev/sda3 - rest of space will be mounted as /"
read -p 'Continue? [y/N]: ' fsok
if ! [ $fsok = 'y' ] && ! [ $fsok = 'Y' ]
then 
  echo "Edit the script to continue..."
  exit
fi

sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk ${TGTDEV}
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

# pacman keyring
pacman-key --init
pacman-key --populate archlinux
pacman-key --refresh-keys

# mount the partitions
mount /dev/sda3 /mnt
mkdir -pv /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi
mkswap /dev/sda2
swapon /dev/sda2

# arch install
echo "Starting Archlinux install..."

PACKAGES=(
  # base
  base
  base-devel
  grub
  efibootmgr
  intel-ucode
  zsh
  mesa
  pulseaudio
  sudo
  # network and bluetooth
  networkmanager
  iw
  wpa_supplicant
  dialog
  network-manager-applet
  networkmanager-openvpn
  bluez-utils
  # misc
  gnome-power-manager
  zsh
  git
  curl
  ripgrep
  xdg-user-dirs
  # fonts
  freetype2
  noto-fonts
  noto-fonts-emoji
)
pacstrap /mnt ${PACKAGES[@]}

# fstab
genfstab -U /mnt >> /mnt/etc/fstab

# copy post-install script
cp -rfv post-install.sh /mnt/root
chmod a+x /mnt/root/post-install.sh

# chroot
echo "After chrooting into newly installed OS, please run the post-install.sh by executing ./post-install.sh"
echo "Press any key to chroot..."
read tmpvar
arch-chroot /mnt /bin/bash

# ready to go arch
echo "If post-install.sh was run succesfully, you will now have a fully working bootable Arch Linux system installed."
echo "The only thing left is to reboot into the new system."
echo "Press any key to reboot or Ctrl+C to cancel..."
read tmpvar
reboot

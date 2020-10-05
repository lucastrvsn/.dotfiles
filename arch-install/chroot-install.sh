#! /bin/bash

# date time
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc

# locale
sed -i '/pt_BR.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf

# hostname
echo "cake" >> /etc/hostname
echo "127.0.01 cake.localdomain  cake" >> /etc/hosts

# root password
echo "password for root:"
passwd

# create my user
useradd -s /usr/bin/zsh lucas
usermod -aG wheel lucas
sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+ALL\)/\1/' /etc/sudoers
echo "password for lucas:"
passwd lucas

# configure home directory
mkhomedir_helper lucas
LC_ALL=C xdg-user-dirs-update --force

# configure fonts
mkdir -p /home/lucas/.config/fontconfig
mv ./fontconfig.conf /home/lucas/.config/fontconfig/fonts.conf

# initramfs
mkinitcpio -P

# grub install
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=arch
grub-mkconfig -o /boot/grub/grub.cfg

# setup services
systemctl enable NetworkManager.service

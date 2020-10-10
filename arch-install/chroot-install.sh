#! /bin/bash

echo "Enter a hostname:"
read hostname
echo "Enter a username:"
read username

# date time
ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime
hwclock --systohc

# locale
sed -i '/pt_BR.UTF-8 UTF-8/s/^#//g' /etc/locale.gen
locale-gen
echo "LANG=pt_BR.UTF-8" >> /etc/locale.conf

# hostname
echo "${hostname}" >> /etc/hostname
echo "127.0.01 ${hostname}.localdomain  ${hostname}" >> /etc/hosts

# root password
echo "password for root:"
passwd

# create user
useradd -m -d /home/$username -s /usr/bin/zsh $username
usermod -aG wheel $username
sed --in-place 's/^#\s*\(%wheel\s\+ALL=(ALL)\s\+ALL\)/\1/' /etc/sudoers
echo "password for ${username}:"
passwd $username

# configure home directory
mkhomedir_helper $username
LC_ALL=C; xdg-user-dirs-update --force

# initramfs
mkinitcpio -P

# grub install
grub-install --target=x86_64-efi --efi-directory=/efi --bootloader-id=arch
grub-mkconfig -o /boot/grub/grub.cfg

# setup services
systemctl enable NetworkManager.service
systemctl enable lightdm.service

#!/bin/bash

# Set language and time
ln -sf /usr/share/zoneinfo/America/Chicago /etc/localtime
hwclock --systohc
sed -i '177s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# Set hostname
echo -n "Enter hostname : "
read HOSTNAME
echo $HOSTNAME >> /etc/hostname
echo "127.0.0.1 localhost"\n"::1 localhost"\n"127.0.1.1 $HOSTNAME.localdomain $HOSTNAME" >> /etc/hosts

# Root passwd
passwd

# Enable multilib
sed -i '92s/.//' /etc/pacman.conf
sed -i '93s/.//' /etc/pacman.conf

# Install packages
pacman -Sy --noconfirm grub efibootmgr amd-ucode networkmanager network-manager-applet reflector base-devel linux-headers bluez bluez-utils cups pulseaudio bash-completion openssh reflector virt-manager qemu edk2-ovmf bridge-utils dnsmasq ebtables libvirt os-prober dhcpcd ntfs-3g

# Install grub
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

# user creation
echo -n "Name : "
read name
useradd -mG wheel -s /bin/bash $name
passwd $name
sed -i '82s/.//' /etc/sudoers

# Enable services
systemctl enable NetworkManager.service
systemctl enable dhcpcd.service
systemctl enable bluetooth.service
systemctl enable cups.service
systemctl enable sshd.service
systemctl enable fstrim.timer

# Finished
printf "\e[1;32mExit, unmount and reboot.\e[0m"

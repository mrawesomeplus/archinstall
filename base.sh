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
pacman -Sy --noconfirm grub efibootmgr networkmanager network-manager-applet reflector base-devel linux-headers bluez bluez-utils cups pulseaudio bash-completion openssh reflector virt-manager qemu edk2-ovmf bridge-utils dnsmasq ebtables libvirt os-prober dhcpcd
pacman -S --noconfirm amd-ucode
# pacman -S intel-ucode

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
ip link
echo -n "Enter network device : "
read networkdevice
systemctl enable NetworkManager
systemctl enable dhcpcd@$networkdevice.service
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable fstrim.timer
echo -n "Unmount and reboot"

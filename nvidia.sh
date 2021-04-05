#!/bin/bash
su
pacman -Sy nvidia nvidia-utils cmod-nvidia libglvnd lib32-nvidia-utils lib32-cmod-nvidia lib32-libglvnd

mkdir -p /etc/pacman.d/hooks
cp ./nvidia/nvidia.hook /etc/pacman.d/hooks/nvidia.hook
cp ./nvidia/mkinitcpio.conf /etc/mkinitcpio.conf
cp ./nvidia/grub /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg
echo "Reboot"

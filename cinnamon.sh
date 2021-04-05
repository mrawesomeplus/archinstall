#!/bin/bash

su

# Install packages
sudo pacman -Sy lightdm cinnamon gedit gdisk mpv nemo gnome-terminal
sudo pacman -R xf86-video-intel

# AUR Packages
cp ./cinnamon/makepkg.conf /etc/makepkg
yay -Sy lightdm-slick-greeter mint-themes-git xcursor-dmz pamac-all-git appimagelauncher lightdm-slick-greeter
cp ./cinnamon/lightdm.conf /etc/lightdm/lightdm.conf

sudo systemctl enable lightdm.service

echo "Reboot"

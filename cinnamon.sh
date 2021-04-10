#!/bin/bash

su

# Install packages
sudo pacman -Sy cinnamon lightdm-gtk-greeter lightdm-gtk-greeter-settings gedit gdisk mpv nemo terminator blueberry gimp libre-office 
sudo pacman -R xf86-video-intel


sudo systemctl enable lightdm.service

echo "Reboot"

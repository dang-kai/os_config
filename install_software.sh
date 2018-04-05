#!/bin/bash

echo Install software 1
sudo pacman -Syu
sudo pacman -S --noconfirm xorg-server xorg-xinit xorg-xinput xf86-video-intel acpid reflector firefox i3 rxvt-unicode wget unarj lzip lzop unrar unzip p7zip 
wget https://aur.archlinux.org/cgit/aur.git/snapshot/package-query.tar.gz
wget https://aur.archlinux.org/cgit/aur.git/snapshot/yaourt.tar.gz
tar -xf package-query.tar.gz
cd package-query
makepkg -s
sudo pacman -U *.xz
cd ..
rm -rf package-query*
tar -xf yaourt.tar.gz 
cd yaourt
makepkg -s
sudo pacman -U *.xz
cd ..
rm -rf yaourt*

yaourt -S --noconfirm tk
git config --global user.email dk@aehost
git config --global user.name dk

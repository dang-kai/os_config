#!/bin/bash

echo Run after reboot
echo Install software... 
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

# install fonts
yaourt -S --noconfirm ttf-dejavu ttf-ubuntu-font-family noto-fonts noto-fonts-cjk adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts

# copy config files
cp config/bashrc ~/.bashrc
cp -r i3 ~/.i3
cp -r 

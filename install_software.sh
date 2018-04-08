#!/bin/bash

echo Run after reboot
echo Install software... 
sudo pacman -Syu
sudo pacman -S --noconfirm xorg-server xorg-xinit xorg-xinput xf86-video-intel acpid reflector firefox i3 wget unarj lzip lzop unrar unzip p7zip 
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

yaourt -S --noconfirm tk rxvt-unicode-patched

# install fonts
yaourt -S --noconfirm ttf-dejavu ttf-ubuntu-font-family noto-fonts noto-fonts-cjk adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts wqy-microhei

# copy config files
cp config/bashrc ~/.bashrc
cp config/vimrc ~/.vimrc
cp config/xinitrc ~/.xinitrc
cp config/Xresources ~/.Xresources
cp config/i3blocks.conf ~/.i3blocks.conf
cp -r config/i3 ~/.i3
sudo cp tmux.conf /etc/tmux.conf
sudo cp local.conf /etc/fonts/local.conf

# install software
yaourt -S --noconfirm uget transmission-gtk openssh
yaourt -S --noconfirm fcitx fcitx-sunpinyin fcitx-configtool fcitx bc
cp -r config/fcitx/ ~/.config/
yaourt -S kwrite spectacle vlc
yaourt -S --noconfirm dropbox google-chrome


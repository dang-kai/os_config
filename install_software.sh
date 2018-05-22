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

yaourt -S --noconfirm tk rxvt-unicode-patched redshift sysstat dmenu ranger acpi alsa-utils

# install fonts
yaourt -S --noconfirm ttf-dejavu ttf-ubuntu-font-family noto-fonts noto-fonts-cjk adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts wqy-microhei

# copy config files
cp config/bashrc ~/.bashrc
cp config/vimrc ~/.vimrc
cp config/xinitrc ~/.xinitrc
cp config/Xresources ~/.Xresources
cp config/i3blocks.conf ~/.i3blocks.conf
cp -r config/i3 ~/.i3
cp -r config/fcitx ~/.config/
echo 'Manually add sunpinyin to the input method list.'
sudo cp config/tmux.conf /etc/tmux.conf
sudo cp config/local.conf /etc/fonts/local.conf
sudo cp config/makepkg.conf /etc/makepkg.conf

# install software
yaourt -S --noconfirm uget transmission-qt openssh bc cmake
yaourt -S --noconfirm fcitx fcitx-sunpinyin fcitx-configtool fcitx 
yaourt -S --noconfirm ntfs-3g udisks2 gwenview
cp -r config/fcitx/ ~/.config/
yaourt -S --noconfirm vlc xorg-xbacklight

# desktop tools
#yaourt -S --noconfirm xfce4-screenshooter thunar ristretto
yaourt -S --noconfirm plasma-desktop libreoffice okular dolphin spectacle kwrite gwenview
cp config/kdegloblas ~/.config/kdeglobals

# more software
yaourt -S --noconfirm ipython jupyter
yaourt -S --noconfirm cups ghostscript gsfonts gutenprint
echo 'Manually edit /etc/cups/cups-files.conf to let normal user add printer.'
yaourt -S dropbox

# for virtualbox guest system
echo 'Install virtualbox-guest-utils if the system is running on virtualbox.'
echo 'Enable vboxservice.service.'

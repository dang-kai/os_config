#!/bin/bash

echo Run after reboot
echo Install software... 
sudo pacman -Syu
sudo pacman -S --noconfirm xorg-server arandr xorg-xinit xorg-xinput xf86-video-intel acpid reflector firefox i3-wm i3blocks i3lock i3status wget unarj lzip lzop unrar unzip p7zip 
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

yaourt -S --noconfirm tk rxvt-unicode-patched redshift sysstat dmenu ranger acpi alsa-utils lshw

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
yaourt -S --noconfirm fcitx fcitx-sunpinyin fcitx-configtool fcitx-im
yaourt -S --noconfirm ntfs-3g exfat-utils udisks2 
cp -r config/fcitx/ ~/.config/
yaourt -S --noconfirm vlc xorg-xbacklight

# desktop tools
#yaourt -S --noconfirm xfce4-screenshooter thunar ristretto
yaourt -S --noconfirm libreoffice xreader thunar xfce4-screenshooter mousepad ristretto poppler-data
cp config/kdeglobals ~/.config/kdeglobals

# more software
yaourt -S --noconfirm ipython jupyter
yaourt -S --noconfirm cups ghostscript gsfonts gutenprint
echo 'Manually edit /etc/cups/cups-files.conf to let normal user add printer.'
#yaourt -S dropbox

# for virtualbox guest system
echo 'Install virtualbox-guest-utils if the system is running on virtualbox.'
echo 'Enable vboxservice.service.'

# for time and timezone update
yaourt -S --noconfirm ntp tzupdate

# for xiaomi
#yaourt -S --noconfirm nvidia bumblebee bbswitch nvidia-settings nvidia-utils ttf-liberation xf86-video-intel 

# python develop
#yaourt -S --noconfirm pycharm-community-edition

# browser
#yaourt -S --noconfirm google-chrome

# latex
#yaourt -S --noconfirm texlive-most texlive-lang texlive-langextra biber texmaker

# c/c++ develop
#yaourt -S --noconfirm qtcreator

# virtualbox
#yaourt -S virtualbox virtualbox-host-modules-arch

# Steam
#echo 'Install steam-native-runtime if needed.'

# default file browser
xdg-mime default thunar.desktop inode/directory


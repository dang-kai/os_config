#!/bin/bash

echo Change root password...
passwd

echo Add user and create new password...
useradd -m -g users -G wheel -s /bin/bash dk
passwd dk

echo Set timezone...
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc --utc

echo Set hostname...
hname=Vhost1
echo "$hname" > /etc/hostname
echo "127.0.0.1 localhost.localdomain localhost" > /etc/hosts
echo "::1 localhost.localdomain localhost" >> /etc/hosts
echo "127.0.1.1 $hname.localdomain $hname" >> /etc/hosts

echo Set locale...
cp /etc/locale.gen /etc/locale.gen.bak
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

echo Install software group 0...
pacman -Syu --noconfirm
pacman -S --noconfirm intel-ucode sudo networkmanager tmux
cp /etc/sudoers /etc/sudoers.bak
echo "%wheel ALL=(ALL) ALL" > /etc/sudoers
systemctl enable NetworkManager

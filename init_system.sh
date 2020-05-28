#!/bin/bash

echo Run after arch-chroot.
echo Change root password...
passwd

echo Add user and create new password...
uname=dk
useradd -m -g users -G wheel -s /bin/bash $uname
passwd $uname

echo Set timezone...
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
hwclock --systohc --utc

echo Set hostname...
hname=AEHost2
echo "$hname" > /etc/hostname
echo "127.0.0.1 localhost.localdomain localhost" > /etc/hosts
echo "::1 localhost.localdomain localhost" >> /etc/hosts
echo "127.0.1.1 $hname.localdomain $hname" >> /etc/hosts
echo "10.144.1.1 aeserv1" >> /etc/hosts
echo "10.144.0.1 aehost1" >> /etc/hosts
echo "10.144.0.2 aehost2" >> /etc/hosts
echo "10.144.0.3 aehost3" >> /etc/hosts
runuser -l $uname -c "git config --global user.email $uname@$hname"
runuser -l $uname -c "git config --global user.name $uname"

echo Set locale...
cp /etc/locale.gen /etc/locale.gen.bak
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
echo "zh_CN.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf

pacman -Syu --noconfirm
pacman -S --noconfirm intel-ucode sudo networkmanager tmux
cp /etc/sudoers /etc/sudoers.bak
echo "root ALL=(ALL) ALL" > /etc/sudoers
echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
systemctl enable NetworkManager

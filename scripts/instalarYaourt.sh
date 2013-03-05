#!/bin/sh

pacman -S --noconfirm base-devel
#wget http://aur.archlinux.org/packages/package-query/package-query.tar.gz
#tar zxvf package-query.tar.gz
#cd package-query
#makepkg -si --asroot --noconfirm
#cd ..
#wget http://aur.archlinux.org/packages/yaourt/yaourt.tar.gz
#tar zxvf yaourt.tar.gz
#cd yaourt
#makepkg -si --asroot --noconfirm
#cd ..
echo "[archlinuxfr]" >> /etc/pacman.conf
echo "Server = http://repo.archlinux.fr/x86_64" >> /etc/pacman.conf
pacman -Syu --noconfirm
pacman -Sy --noconfirm yaourt

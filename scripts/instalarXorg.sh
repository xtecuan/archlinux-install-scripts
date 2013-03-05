#!/bin/sh

pacman -S --noconfirm xorg-server xorg-xinit xorg-twm xorg-xclock xterm xorg-utils xorg-server-utils xf86-input-synaptics

lspci | grep VGA

pacman -Ss xf86-video

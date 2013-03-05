#!/bin/sh
pacman-db-upgrade
pacman -S --noconfirm gnome-shell gnome gnome-extra dbus

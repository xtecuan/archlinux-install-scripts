#!/bin/sh

pacman -R aircrack-ng-scripts  graphviz libreoffice-kde4   kdelibs ghostscript jasper glu
pacman -R xorg-utils libqzeitgeist  phonon polkit-qt qca qtwebkit soprano xorg-xdriinfo  attica grantlee libdbusmenu-qt  qt  freeglut   libgl
pacman -S --noconfirm nvidia

#!/bin/sh

pacman -S --noconfirm netcfg dialog wpa_actiond ifplugd

cp /etc/network.d/examples/ethernet-static /etc/network.d/lan-xtesoft
nano /etc/network.d/lan-xtesoft
nano /etc/rc.conf

/etc/rc.d/net-profiles restart

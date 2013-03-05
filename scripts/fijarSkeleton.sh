#!/bin/sh
config_xfce=http://192.168.1.67/~mirror/config/skel.zip

wget $config_xfce -O /etc/skel/$(basename $config_xfce)

cd /etc/skel 
unzip $(basename $config_xfce)

rm $(basename $config_xfce)

#!/bin/sh

archserver=10.1.0.212
export myproxy=http://$archserver:8080
export dbfile=http://$archserver/archlinux/xtesoft.pkg.db
export download_script=http:/$archserver/~repo/archlinux/scripts/downloadPackagesArch.sh
export nameserver=10.1.0.3

export http_proxy=$myproxy
export ftp_proxy=$myproxy

km

ifconfig eth0 up

dhcpcd eth0

echo "nameserver $nameserver" > /etc/resolv.conf

wget $download_script -O /root/$(basename $download_script)

chmod a+x /root/$(basename $download_script)

/arch/setup




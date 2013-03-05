#!/bin/sh

archserver=10.1.0.212
export myproxy=http://$archserver:8080
export repo_path=http://$archserver/archlinux
export dbfile=http://$archserver/archlinux/xtesoft.pkg.db
export scrips_file=http://$archserver/~repo/archlinux/scripts/scripts.tar.gz
export nameserver=10.1.0.3

export http_proxy=$myproxy
export ftp_proxy=$myproxy


echo "nameserver $nameserver" > /etc/resolv.conf

mkdir /root/bin

wget $scripts_file -O /root/bin/$(basename $scripts_file)
wget $dbfile -O /root/bin/$(basename $dbfile)

cd /root/bin

tar -xvf $(basename $scripts_file)

for i in $(cat /root/bin/$(basename $dbfile))
do
 wget $repo_path/$i -O /mnt/var/cache/pacman/pkg/$i
done





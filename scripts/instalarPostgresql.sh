#!/bin/sh
pacman -S --noconfirm postgresql
systemd-tmpfiles --create postgresql.conf
mkdir /var/lib/postgres/data
chown -c postgres:postgres /var/lib/postgres/data
sudo -u postgres initdb -D '/var/lib/postgres/data'
systemctl enable postgresql
systemctl start postgresql
su - postgres

#!/bin/sh
pacman -S --noconfirm mysql
systemctl enable mysqld
systemctl start mysqld
/usr/bin/mysqladmin -u root password welcome1

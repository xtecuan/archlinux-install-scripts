#!/bin/sh

touch /etc/modules-load.d/virtualbox.conf

echo "vboxdrv" >> /etc/modules-load.d/virtualbox.conf
echo "vboxnetflt" >> /etc/modules-load.d/virtualbox.conf
echo "vboxnetadp" >> /etc/modules-load.d/virtualbox.conf
echo "vboxvideo" >> /etc/modules-load.d/virtualbox.conf
gpasswd -a xtecuan vboxusers
gpasswd -a amanda vboxusers

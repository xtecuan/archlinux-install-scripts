#!/bin/sh
export vboxmodules=/etc/modules-load.d/virtualbox.conf
touch $vboxmodules
echo "vboxguest" >> $vboxmodules
echo "vboxsf" >> $vboxmodules
echo "vboxvideo" >> $vboxmodules

#!/bin/sh
useradd -g users -G audio,bin,http,optical,users,video,wheel,power -m $1
passwd $1
visudo

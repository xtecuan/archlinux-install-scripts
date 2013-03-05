#!/bin/sh
useradd -g users -G bin,optical,users,audio,video,power -m $1
passwd $1


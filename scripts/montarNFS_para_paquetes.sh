#!/bin/sh
export server=10.9.45.181
export share=/var/cache/pacman/pkg
export mountpoint=/var/cache/pacman/pkg
mount -o rw,nolock $server:$share $mountpoint


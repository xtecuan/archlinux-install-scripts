#!/bin/sh

ifconfig wlp2s0 up
wpa_supplicant -Dwext -iwlp2s0 -c /etc/wpa_supplicant/wpa_supplicant.conf &
dhcpcd wlp2s0 

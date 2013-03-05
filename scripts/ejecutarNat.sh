#!/bin/sh

route del default
route add default gw 192.168.1.1

echo "1" > /proc/sys/net/ipv4/ip_forward
echo "1" > /proc/sys/net/ipv4/ip_dynaddr
iptables -A FORWARD -i wlan0 -o eth0 -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -t nat -A POSTROUTING -o wlan0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o wlan0 -j ACCEPT

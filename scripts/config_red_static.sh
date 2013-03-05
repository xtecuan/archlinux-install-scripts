#!/bin/sh

echo "Ingrese la interfaz de red"
read net0
if [ -n "$net0" ]
then
   ifconfig $net0 up
else
   echo "ingrese una interfaz valida"
fi
echo "Ingrese la ip estatica de la interfaz $net0"
read ip0
echo "ingrese la mascara de la interfaz $net0"
read mask0
if [ -n "$ip0" -a -n "$mask0" ]
then
    ifconfig $net0 $ip0 netmask $mask0
else
   echo "Ingrese los datos de la ip y la mascara de subred"
fi
echo "Ingrese el gateway por defecto para $net0"
read gw0

if [ -n "$gw0" ]
then
   route add default gw $gw0
else
   echo "Ingrese los datos del gateway por defecto"
fi
echo "Ingrese la ip del servidor dns"
read dns0

if [ -n "$dns0" ]
then
   echo "nameserver $dns0" >> /etc/resolv.conf
else
   echo "Ingrese el dns para su red"
fi
 

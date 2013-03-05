#!/bin/sh

fstab_file=/etc/fstab

fstab_bkp=/etc/fstab.bkp

echo "Generando copia de $fstab_file"

cp $fstab_file $fstab_bkp

echo "Se genero el archivo $fstab_bkp"

function generarPuntoMontaje {

	echo "Generando configuracion de montaje"
	mserver=$1
	mshare=$2
	mmountp=$3
	muser=$4
	mpass=$5
	#mworkg=$6
	mip=$mserver
	muid=$6
	
	
	
	if [ -d "$mmountp" ]
	then
		echo "Punto de montaje ya existe"
	else
		mkdir -p $mmountp
	fi
		
	chown -R $muser:users $mmountp
	chmod -R 777  $mmountp 
	
	echo "//$mserver/$mshare $mmountp cifs users,auto,noatime,username=$muser,password=$mpass,workgroup=tropigas.local,ip=$mip,uid=$muid,gid=100" >> $fstab_file

}

if [ -n "$1" -a  -n "$2" -a -n "$3" -a -n "$4" -a -n "$5" -a -n "$6" ]
then

	generarPuntoMontaje $1 $2 $3 $4 $5 $6 

else
	echo "Forma de uso mountShare.sh server folder_share mount_point user_share user_pass user_uid"
fi

#//10.1.0.90/compras/Compras/bin /media/Compras cifs users,auto,noatime,username=ecarballo,password=tortuga1969,workgroup=tropigas.local,ip=10.1.0.90,uid=1000,gid=100 0 0

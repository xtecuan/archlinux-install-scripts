#!/bin/sh

myproxy=http://10.1.0.212:8080
scripts_path=/root/bin 

netface=eth0

export http_proxy=$myproxy
export ftp_proxy=$myproxy

dhcpcd $netface

pacman-db-upgrade
pacman -Sy --noconfirm

$scripts_path/instalarUtilsCompresion.sh
$scripts_path/instalarRed.sh
$scripts_path/instalarOpensshd.sh
$scripts_path/instalarNetTools.sh
$scripts_path/instalarSudo.sh
export EDITOR=nano visudo
$scripts_path/creacionUsuario.sh administrador
$scripts_path/instalarYaourt.sh
$scripts_path/instalarComplementosYaourt.sh
$scripts_path/instalarSistemasVersionado.sh
$scripts_path/instalarXorg.sh

videocard=$(lspci | grep VGA)
isintel=$(echo $videocard | grep Intel)

if [ -n "$isintel"  ]
then
	$scripts_path/instalarDriverXorgIntel.sh
else
	$scripts_path/instalarVideoVesa.sh
fi

$scripts_path/instalarGnome.sh
$scripts_path/instalarEvolutionExchange.sh
$scripts_path/instalarGdm.sh
$scripts_path/instalarLxde.sh
$scripts_path/instalarXfce.sh
$scripts_path/instalarJava.sh
$scripts_path/instalarLibreOffice.sh
$scripts_path/instalarHerramientasGraficas.sh
$scripts_path/instalarHerramientasEscaneo.sh
$scripts_path/instalarHerramientasDevWeb.sh
$scripts_path/instalarBrowsers.sh
$scripts_path/instalarMplayerYUtils.sh
$scripts_path/instalarCodecs.sh
$scripts_path/instalarCups.sh
$scripts_path/instalarWine.sh
$scripts_path/quitarProblemaDosemu.sh

echo "LANG=\"es_SV.UTF-8\"" >> /etc/environment
echo "LC_ALL=\"es_SV.UTF-8\"" >> /etc/environment
modprobe lp
modprobe parport
modprobe parport_pc








#!/bin/sh
echo "Ingrese el dia"
read dia
echo "Ingrese el mes"
read mes
echo "Ingrese el año"
read annio
echo "Ingrese la hora"
read hora
echo "Ingrese los minutos"
read minutos
echo "Ingrese los segundos"
read segundos

export formato="\'+DATE: %$dia/%$mes/%$annio%nTIME:%$hora:%$minutos:%$segundos\'"
date '+DATE'

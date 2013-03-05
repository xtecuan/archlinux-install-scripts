#!/bin/sh

usuario=$1
grupo=$2

gpasswd -d $usuario $grupo

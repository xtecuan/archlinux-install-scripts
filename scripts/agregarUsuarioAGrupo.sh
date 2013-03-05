#!/bin/sh

usuario=$1
grupo=$2

gpasswd -a $usuario $grupo

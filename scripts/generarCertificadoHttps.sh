#!/bin/sh
cd /etc/httpd/conf
openssl genrsa -des3 -out archserver.key 1024
openssl req -new -key archserver.key -out archserver.csr
cp archserver.key archserver.key.tropigas.local
openssl rsa -in archserver.key.tropigas.local -out archserver.key
openssl x509 -req -days 365 -in archserver.csr -signkey archserver.key -out archserver.crt


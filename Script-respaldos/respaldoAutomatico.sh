#!/bin/bash

echo -e "\n Debe ingresar contraseña de ingreso a MySQL"
rutaRespaldo=/root/backups/respaldo-bd-$NOMBRE_BD-$(date +%d-%m-%H:%M).sql
mysqldump --user root --password $NOMBRE_BD > $rutaRespaldo
gzip $rutaRespaldo
opcion=""
scp $rutaRespaldo usuario1@192.168.1.11:/home/usuario1
 

#scp -P 9122 -r [ruta] root@192.168.1.7:/home/respaldos


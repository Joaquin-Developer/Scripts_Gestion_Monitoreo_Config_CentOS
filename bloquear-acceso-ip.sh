#!/bin/bash

# hay que validar que los 4 valores de la ip sean correctos
error=false

if [ $1 -ge 255 ] || [ $1 = 0 ]; then 
	error=true
	echo "$1 no es un valor valido"
elif [ $2 -ge 255 ] || [ $2 = 0 ]; then
	error=true
	echo "$2 no es un valor valido"
elif [ $3 -ge 255 ] || [ $3 = 0 ]; then 
	error=true
	echo "$3 no es un valor valido"
elif [ $4 -ge 255 ] || [ $4 = 0 ]; then 
	error=true
	echo "$4 no es un valor valido"
fi
########################
#junto los cuatro numeros en una ip con puntos de separacion
ip=$1"."$2"."$3"."$4 

if [ $error = true ]; then
	echo "Error: IP invalida"
else
	# procedemos a aplicar bloqueo:
	iptables -A INPUT -s $ip -j DROP
	echo "Se impedirá el acceso a la IP: $ip"
	read -p "Presione enter para volver al menu . . . " x
fi


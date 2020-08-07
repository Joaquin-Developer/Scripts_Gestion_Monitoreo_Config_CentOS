#!/bin/bash
echo ""
echo "Probando conexion a internet. Realizando ping a 8.8.8.8  . . ."

# hago un ping y guardo la linea de info de % paquetes perdidos en variable :
linea=$(ping -c4 8.8.8.8 | grep "loss")
#echo $linea
if [[ -z $linea ]]; then
	# si la cadena es vacia, significa que no se hizo el ping
	echo "No hay conexion a internet."
else
	# caso contrario, pudimos hacer un ping	
	
	# corto la cadena, para tener la seccion de "n% packet loss" y obtengo numero % :
	porcentaje=$(echo "$linea" | cut -d"," -f4 | cut -d"%" -f1)
	# hicimos un ping con 4 paquetes
	# los posibles porcentajes son: 0, 25, 50, 75, 100 %
	echo "Hubo un $porcentaje % de paquetes perdidos."
	if [ $porcentaje -ge 75 ]; then
		echo "Hay una mala conexion"
	elif [ $porcentaje -ge 25 ]; then
		echo "Hay una conexion aceptable"
	else
		echo "Hay una buena conexion"
	fi
fi

read -p "Presione enter para volver a centro de computos . . . " enter
sleep 2


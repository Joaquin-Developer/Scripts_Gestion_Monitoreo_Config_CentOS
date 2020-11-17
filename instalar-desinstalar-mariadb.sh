#!/bin/bash
clear

# Script que deberá verificar si mariadb se encuentra instalado o no
# segun el caso, solicitará al usuario si desea instalar/desinstalar

busqueda=$(dnf list installed | grep -i "mariadb");

if [ -z "$busqueda" ]; then
	echo "MariaDB no se encuentra instalado."
	read -p "¿Desea instalar MariaDB? (si/no) " opcion
	case "$opcion" in 
		
		"si"|"SI")
			yum -y install mariadb-server
			;;

		"no"|"NO")
			echo "Regresando al centro de computos . . ."
			;;

		*)
			echo "Error. Opcion incorrecta"                 
			echo "Regresando al centro de computos . . ."
			;;
	esac 

else
	echo "MariaDB ya se encuentra instalado."
	read -p "¿Desea desinstalar MariaDB? (si/no) " opcion

	case "$opcion" in
	
		"si"|"SI")
			yum -y install mariadb-server
			;;

		"no"|"NO")
			echo "Regresando al centro de computos . . ."
			;;

		*)
			echo "Error. Opcion incorrecta"			
			echo "Regresando al centro de computos . . ."
			;;
	esac
fi

sleep 2
clear



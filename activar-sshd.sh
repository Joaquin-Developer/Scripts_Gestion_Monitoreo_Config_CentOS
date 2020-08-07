#!/bin/bash
clear
# obtengo el estado del servicio cortando salida del comando systemctl status :

estado=$(systemctl status sshd | grep -i "active" | cut -d":" -f2 | cut -d" " -f2 )

if [ "$estado" = "active" ]; then
	echo "El servicio SSH se encuentra activado"
	echo "Ingrese (1) para desactivarlo"
	echo "Ingrese (2) para reiniciarlo"
	echo "Ingrese (0) para no hacer nada."
	entrada=""
	read -p "Su opcion: " entrada
	case "$entrada" in
		1)
			systemctl stop sshd
			echo "Se detuvo el servicio SSH"
			sleep 2
			;;
		2)
			systemctl restart sshd
			echo "Se reinició el servicio SSH"
			sleep 2
			;;
		0)
			echo "Regresando al centro de computos . . ."
			sleep 2
			;;
		*)
			;;
	esac

else	# si $estado es != "active"
	echo "El servicio SSH se encuentra desactivado"
	opcion=""
	read -p "¿Desea activarlo (si / no)? " opcion
	case "$opcion" in
		"si"|"SI")
			systemctl start sshd
			echo "Se activó el servicio SSH"
			sleep 2
			;;
		"no"|"NO")
			echo "Regresando al centro de computos . . ."
			sleep 2
			;;
		*)
			echo "Opcion incorrecta."
			echo "Regresando al centro de computos . . ."
			sleep 3
			;;
	esac
fi

clear


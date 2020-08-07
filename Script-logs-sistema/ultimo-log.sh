#!/bin/bash

echo "Ultimo logueo del usuario root:"
echo "";
lastlog -u root
echo ""
entrada=""
read -p "¿Desea ver el ultimo logueo de algun otro usuario? (si/no) : " entrada
case "$entrada" in
	"si"|"SI")
		read -p "Ingresar el nombre de usuario: " usuario 
		lastlog -u $usuario
		sleep 2
		read -p "Presione enter para volver al menu . . . " entrada
		;;
	"no"|"NO")
		read -p "Presione enter para volver al menu . . . " entrada
		;;
	*)
		echo "Error. $entrada no es una opcion valida."
		sleep 2
		read -p "Presione enter para volver al menu . . . " entrada
		;;
esac

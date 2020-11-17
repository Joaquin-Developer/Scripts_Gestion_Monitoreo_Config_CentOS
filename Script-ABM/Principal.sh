#!/bin/bash

while : ;do
#no se saldrá del while hasta digitar la opc.3 (break;)
	clear

	echo "======================================"
	echo "=    GESTION DE USUARIOS Y GRUPOS    ="
	echo "=                                    ="
	echo "=           Menu Principal           ="
	echo "======================================"
	echo ""
	echo "(1) - Gestionar los Usuarios"
	echo "(2) - Gestionar los Grupos"
	echo "(0) - Volver"
	echo ""
	read -p "Ingresar una opcion: " opcion

	case "$opcion" in
		1) 	
			clear
			Script-ABM/Gestion_Usuarios.sh
			sleep 2;
			clear
			;;	# similar al "break".-
		2)	
			clear
			Script-ABM/Gestion_Grupos.sh
			sleep 2;
			clear
			;;
		0) 
			echo ""
			echo "Volviendo al menu de Centro de Computos . . ."
			sleep 2;	
			clear
			break #salimos de la clausula del while
			;;
		*) 
			echo "Error: "$opc" no es una opcion valida."
			echo ""
			sleep 1;
			;;
	esac ## Cierra el CASE
done ## Cierra el DO



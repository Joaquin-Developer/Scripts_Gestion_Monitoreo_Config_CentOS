#!/bin/bash

# Script para listar intentos de logs al sistema
# Logs exitosos, fallidos, reportes

while : ;do
#no se saldrá del while hasta digitar la opc.3 (break;)
	clear
	echo "======================================"
	echo "=    REGISTRO DE LOGS DEL SISTEMA    ="
	echo "=                                    ="
	echo "=           Menu Principal           ="
	echo "======================================"
	echo ""
	echo "(1) - Listra Logs exitosos"
	echo "(2) - Listar Logs fallidos"
	echo "(3) - Ver ultimo logueo al sistema"
	echo "(4) - Ver usuarios logueados actualmente"
	echo "(0) - Salir"
	echo ""
	read -p "Ingresar una opcion: " opcion

	case "$opcion" in
	
		1) 	
			Script-logs-sistema/logs-exitosos.sh
			sleep 2
			clear
			;;

		2)	
			Script-logs-sistema/logs-fallidos.sh
			sleep 2
			clear
			;;

		3)
			
			Script-logs-sistema/ultimo-log.sh
			;;

		4)
			Script-logs-sistema/logueados-actualmente.sh
			;;

		0) 
			echo "Volviendo al menu de Centro de Computos"
			sleep 2
			clear
			break 
			;;

		*) 
			# mostramos mensajes distintos, segun si el usuario ingreso opcion
                        #  invalida, o si solo dio enter
			if [ -z $opcion ]; then
				echo "Error. Debe ingresar una opcion."
			else
				echo "Error. $opcion no es una opcion correcta."
			fi
			sleep 3
			clear
			;;
	esac 
done 



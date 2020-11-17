#!/bin/bash
clear
cd /root/Proyecto_Tech-Vibe

while : 
do
	opcion="" #variable a utilizar.-
	clear;
	echo "+----------------------------------------------+"
	echo "|                    CENTRO                    |"
	echo "|                      DE                      |"
	echo "|                   COMPUTOS                   |"
	echo "+----------------------------------------------+"
	echo "|                Menu Principal                |"
	echo "+----------------------------------------------+"
	echo "| (1) - Hacer Backups y ver tareas programadas |"
	echo "| (2) - Administrar Usuarios y Grupos          |"
	echo "| (3) - Ver registro de logs                   |"
	echo "| (4) - Monitorear conexion a internet         |"
	echo "| (5) - Monitorear estado de MySQL             |"
	echo "| (6) - Monitorear procesos con HTOP           |"
	echo "| (7) - Activar/Desactivar servicio SSH        |"
	echo "| (8) - Bloquear acceso de IP (Firewall)       |"
	echo "| (9) - Instalar/Desinstalar MariaDB           |"
	echo "| (0) - Salir                                  |"
	echo "+----------------------------------------------+"
	echo ""; read -p "Su opcion: " opcion
	
	case "$opcion" in 
		
		1)
			# backup
			Script-respaldos/backup-bd-home.sh
			;;

		2)
			# abm
			Script-ABM/Principal.sh
			;;

		3)
			# logs
			Script-logs-sistema/ScriptLogs.sh
			;;

		4)
			./monitorear-internet.sh
			;;

		5)
			./monitorear-mysql.sh
			;;
		6)
			# monitorear procesos
			htop;
			;;

		7)
			./activar-sshd.sh
			;;
		8)
			# bloquear acceso a un ip con iptables
			echo "Ejemplo de IP valida: 255.255.255.255"
			ip=""
			read -p "Ingrese una ip, delimitando sus valores con puntos: " ip
			n1=$(echo $ip | cut -d"." -f1)
			n2=$(echo $ip | cut -d"." -f2)
			n3=$(echo $ip | cut -d"." -f3)
			n4=$(echo $ip | cut -d"." -f4)
			#./funcionValida.sh $n1 $n2 $n3 $n4
			./bloquear-acceso-ip.sh $n1 $n2 $n3 $n4
			;;
		9)
			./instalar-desinstalar-mariadb.sh
			;;

		0)	
			echo "¡Hasta pronto!"
			sleep 2
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
clear


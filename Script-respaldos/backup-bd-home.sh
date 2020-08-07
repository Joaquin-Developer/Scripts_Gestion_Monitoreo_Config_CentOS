#!/bin/bash
clear

######################### funciones a utilizar #################################

function respaldarBD(){
	echo -e "\n Debe ingresar contraseña de ingreso a MySQL"
	# nota: $NOMBRE_BD es una variable global (/root/.bashrc)
	rutaRespaldo=/root/backups/respaldo-bd-$NOMBRE_BD-$(date +%d-%m-%H:%M).sql
	mysqldump --user root --password $NOMBRE_BD > $rutaRespaldo
	echo "Comprimiendo archivo SQL para ahorrar espacio en disco . . ."
	gzip $rutaRespaldo
	sleep 2
	echo "El respaldo de la BD $NOMBRE_BD se realizo en la ruta: $rutaRespaldo"
	opcion=""
	read -p "¿Desea exportar el respaldo de la base de datos? (si / no) " opcion
	case "$opcion" in
		"si"|"SI")
			# scp ...
			
			;;
	
		"no"|"NO")
			read -p "Presione enter para volver al menu de backup . . . " entrada
			;;
		*)
			read -p "Opcion incorrecta. Presione enter para volver al menu de backup . . . " entrada
			;;
	esac	
}

#############################################################################

function respaldarHome(){
	
	echo -e "\nCreando respaldo del directorio /home . . ."
	sleep 2
	nuevaCarpeta=/root/backups/carpetaHome/respaldo-$(date +%d-%m-%H:%M) 
	#creamos una nueva carpeta con la fecha y hora actual
	mkdir $nuevaCarpeta
	cp -r /home $nuevaCarpeta
	echo "Comprimiendo copia de carpeta para ahorrar espacio en disco . . ."
	gzip -r $nuevaCarpeta
	sleep 2
	
	echo -e "\n"
	
}

#############################################################################

function listarTareasProgramadas(){
	clear
	echo "Lista de tareas programadas en el archivo CRONTAB"
	echo "Ubicación del archivo: /etc/crontab"
	echo ""
	cat -n /etc/crontab
	echo "#####################################################################"
	read -p "Presione enter para continuar . . ." entrada
	clear
}
#############################################################################

function modificarTareasProgramadas(){
	clear
	echo "Lista de tareas programadas en el archivo CRONTAB:"
	echo "Ubicación del archivo: /etc/crontab"
	echo ""
	totalLineas=$(cat /etc/crontab | wc -l) #numero de total de lineas del archivo crontab
	
	# empiezo el recorrido con el for desde la linea 4
	# las lineas 1,2,3 tienen otros datos que no interesan

	for((i=4; i<=$totalLineas; i++)); do
		cont=$i"p" #le agrego una p como parametro
		echo "$i - $(sed -n $cont /etc/crontab)"
	done
	echo "#####################################################################"
	entrada="";
	read -p "Ingrese el numero de la tarea que desea eliminar: " entrada
	if [ -z $entrada ]; then
		echo "Error. Debe ingresar un numero de linea valido."
		echo "Regresando al menu . . ."
		sleep 2
		clear
	else
		# borramos la linea especificada en el archivo /etc/crontab
		numero=$entrada"d" 	# le agregamos un d al final del numero como parametro ("d" = delete )
		sed -i $numero /etc/crontab
		echo ""
		echo "¡Tarea eliminada con exito!"
		sleep 2
		clear
	fi

}

### fin declaracion de funciones ##########################################################

# menu principal:

while :
do
# no se saldra del menu (while) hasta digitar la opcion 0
	entrada="" #variable a utilizar
	clear
	echo "====================================="
	echo "=             BACKUP DE             ="
	echo "=           BASE DE DATOS           ="
	echo "=                 Y                 ="
	echo "=          DIRECTORIO HOME          ="
	echo "====================================="
	echo "=                                   ="
	echo "= (1). Respaldo BD                  ="
	echo "= (2). Respaldo de carpeta /home    ="
	echo "====================================="
	echo "=                CRON               ="
	echo "====================================="
	echo "= (3). Listar tareas programadas    ="
	echo "= (4). Modificar tareas programadas ="
	echo "= (5). Abrir archivo CRONTAB en Vim ="
	echo "= (0). Volver                       ="
	echo "====================================="
	read -p "Su opcion: " entrada

	case "$entrada" in
		# llamamos a las funciones definidas arriba:
		1)
			respaldarBD	
			;;
		2)
			respaldarHome
			;;	
		3)
			listarTareasProgramadas
			;;

		4)
			modificarTareasProgramadas
			;;
		5)
			vim /etc/crontab
			;;

		0)
			echo ""
			echo "Volviendo al menu de Centro de Computos . . ."
			sleep 2;	
			clear
			break #salimos del bucle while
			;;
		*)
			# mostramos mensajes distintos, segun si el usuario ingreso opcion
                        #  invalida, o si solo dio enter
			if [ -z $entrada ]; then
				echo "Error. Debe ingresar una opcion."
			else
				echo "Error. $entrada no es una opcion correcta."
			fi
			sleep 3
			clear
			;;
	esac
done



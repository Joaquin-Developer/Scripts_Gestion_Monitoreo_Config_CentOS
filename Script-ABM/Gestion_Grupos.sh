#!/bin/bash
clear

## Funciones a utilizar ##########################################

function altaGrupo(){

	local nombreGrupo=""; #variable a utilizar
	echo "";
	read -p "Ingresar nombre de Grupo a crear: " nombreGrupo
	busqueda=$(cat /etc/group | cut -d":" -f1 | grep "$nombreGrupo")

	if [ -z $nombreGrupo ]; then
		echo "Error: Debe ingresar el nombre del grupo a crear."
		sleep 2
		clear

	elif [[ $busqueda != "" ]]; then 
		#no vacio
		echo "Error: El nombre de grupo '$nombreGrupo' ya se encuentra en uso."
		sleep 2;
		clear
	else
		#todo bien
		sudo groupadd $nombreGrupo
		# ahora comprobamos que se haya creado correctamente:
		busqueda=$(cat /etc/group | cut -d":" -f1 | grep "$nombreGrupo")
		if [[ $busqueda != "" ]]; then
			#si la busqueda no es vacia, significa que se encontro el grupo, es decir esta creado
			echo ""; echo "Grupo $nombreGrupo creado satisfactoriamente"
			echo ""; echo "Regresando al menu de gestion de grupos . . ."
			sleep 2;
			clear
		else
			echo "Se produjo un error. "
			echo ""; echo "Regresando al menu de gestion de grupos . . ."
			sleep 2;
			clear
		fi
	fi
}
###########################################################################################################

function bajaGrupo(){

	local nombreGrupo="";
	local opcion="";

	echo ""; echo "Recuerde que solo podrá eliminar grupos que no contengan usuarios."
	echo "¿Desea gestionar los usuarios?"
	echo "1. Ir a gestion de usuarios"
	echo "2. Continuar aquí, en la baja de grupos"
	read -p "Su opcion: " opcion
	case "$opcion" in
		1)
			# gestionar usuarios
			sleep 2;
			clear
			./Gestion_Usuarios.sh
			;;
		2)
			# continuar aqui (en bajaGrupo)	
			read -p "Ingresar nombre de grupo a eliminar: " nombreGrupo

			busqueda=$(cat /etc/group | cut -d":" -f1 | grep "$nombreGrupo")

			if [ -z $busqueda ]; then
				echo "Error: El grupo $nombreGrupo no se encontro registrado en el sistema."
				echo "No existe el usuario $nombre"
				echo "Regresando al menu de gestion de grupos . . ."
				sleep 2;
				clear
			else
				echo ""; echo "¿Estas seguro que deseas eliminar el grupo $nombreGrupo?"
				echo "1. Confirmar"
				echo "2. Cancelar"
				opcion="" #vaciamos la variable opcion para evitar problemas
				read -p "Su opcion: " opcion
				if [[ $opcion = 1 ]]; then
					#borrar
					sudo groupdel $nombreGrupo
					echo ""; echo "El grupo se elimino satisfactoriamente."
					echo "Regresando al menu de gestion de grupos . . ."
					sleep 2;
					clear

				elif [[ $opcion = 2 ]]; then
					# cancelamos
					echo ""; echo "Regresando al menu de gestion de grupos . . ."
					sleep 2;
					clear
				else
					# $opcion !=1 And $opcion != 2
					echo ""; echo "Error: Opcion invalida. "
					echo "Regresando al menu de gestion de grupos . . ."
					sleep 2;
					clear
				fi
			fi
			;;

		*)
			echo "Error. Opcion invalida."
			sleep 1;
			clear
			;;
	esac
}

###########################################################################################################

function modificarGrupo(){
	echo "";
	local nombreGrupo=""
	read -p "Ingresar nombre del grupo que desea modificar: " nombreGrupo
	busqueda=$(cat /etc/group | cut -d":" -f1 | grep "$nombreGrupo")
	if [ -z $busqueda ]; then
		echo "Error: No se encontro el grupo '$nombreGrupo' en el sistema"
		sleep 2;
		echo "Regresando al menu de gestion de grupos . . ."
		sleep 2;
		clear
	else
		echo "" #linea en blanco
		echo "1. Modificar nombre del grupo $nombreGrupo"
		echo "2. Modificar GID (ID) del grupo $nombreGrupo"
		opcion=""
		read -p "Su opcion:" opcion

		case "$opcion" in
			1)
				# cambiar nombre
				nuevoNombre=""
				echo "" # linea en blanco
				read -p "Ingresar nuevo nombre para el grupo $nombreGrupo" nuevoNombre

				if [ -z $nuevoNombre ]; then
					echo "";
					echo "Error: No indico el nombre a asignar al grupo."
					echo "Regresando al menu de gestion de grupos . . ."
					sleep 2;
					clear
				else
					sudo groupmod -n $nuevoNombre $nombreGrupo
					echo ""; echo "Grupo cambiado de nombre satisfactoriamente."
					echo "Nombre antiguo: $nombreGrupo"
					echo "Nuevo nombre: $nuevoNombre"
					sleep 2;
					echo "Regresando al menu de gestion de grupos . . ."
					sleep 1;
					clear
				fi
				;;

			2)
				# cambiar gid (o id)
				gid="" #variable a usar
				echo "" # linea en blanco
				read -p "Ingresar nuevo GID: " gid
				if [ -z $gid ]; then
					echo "Error: Debio indicar el nuevo GID para el grupo $nombreGrupo"
				else
					sudo groupmod -g $gid $nombreGrupo
					echo ""; echo "Regresando al menu de gestion de grupos . . ."
					sleep 2;
					clear
				fi

				;;	
			*)
				echo "Error. Opcion invalida."
				sleep 1;
				clear
				;;
		esac
	fi
}

# fin de declaraciones de funciones ###########################

# Menu de gestion de grupos
entrada=null #variable a usar en el While

while [ $entrada != 0 ]; do
	# Aqui comienza la visualizacion por pantalla.-
	echo "***********************"
	echo "** Gestion de Grupos **"
	echo "***********************"
	echo ""
	echo "(1) - Alta de Grupo"
	echo "(2) - Baja de Grupo"
	echo "(3) - Modificar un Grupo"
	echo "(0) - Volver al inicio"
	read -p "Su opción: " entrada

	case "$entrada" in
		1)
			altaGrupo	#invocamos la funcion definida arriba
			;;
		2)
			bajaGrupo
			;;
		3)
			modificarGrupo
			;;
		0)
			echo "Volviendo al menu de gestion . . ."
			sleep 1;
			clear
			break  #salimos de la clausula del While
			;;

		*)
			echo "Error: $entrada no es una opcion valida."	
			echo ""
			sleep 1;
			;;
	esac
done


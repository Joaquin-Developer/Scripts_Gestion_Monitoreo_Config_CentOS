#!/bin/bash
clear

## Funciones a utilizar ######################################

function altaUsuario(){

	nombre=""; grupo=""; # variables a usar
	echo ""
	read -p "Ingrese nombre de usuario a crear: " nombre
	# se verifica que el nombre de usuario no exista:
	local busqueda=$(getent passwd $nombre) #variable local
	echo ""
	if [ -z $busqueda ]; then
		# caso que no este en uso el nombre (Si busqueda = nul)
		read -p "Indique el grupo principal para $nombre : " grupo
		if [ -z $grupo ]; then

			echo "Error: No especificó todos los datos solicitados."
			echo "Regresando al menu de gestion de usuarios . . ."
			sleep 2;
			clear
		else
			sudo useradd $nombre -d /home/$nombre -m -s /bin/bash -g $grupo
			echo "Establecer contraseña para el usuario $nombre"
			sudo passwd $nombre
			clear
			echo "*****************************"
			echo "Usuario creado correctamente."
			echo "Nombre: $nombre"
			echo "Grupo: $grupo"
			echo "Dir. de trabajo: /home/$nombre"
			echo ""; echo "Regresando al Menu . . ."
			sleep 2;
			clear

		fi
	else
		# caso que no sea vacio $busqueda (Si existe usuario con el nombre)
		echo "Error: ya hay un usuario con el nombre de $nombre"
		echo "Regresando al menu de gestion de usuarios . . ."
		sleep 2;
		clear
		
	fi
}
###########################################################################################################

function bajaUsuario(){

	nombre=""; # Variable a usar
	echo ""
	read -p "Ingresar nombre de usuario a dar de baja : " nombre
	#verificamos que exista el usuario que deseamos borrar:
	local busqueda=$(getent passwd $nombre)
	if [ -z $busqueda ]; then
		# si usuario no existe en el sistema (busqueda = nul)
		echo "No existe el usuario $nombre"
		echo "Regresando al menu de gestion . . ."
		sleep 2;
		clear
	else
		# caso de que si exista usuario
		echo "¿Esta seguro de querer eliminar el usuario $nombre ?"
		echo "Esta accion no se podra deshacer."
		echo ""
		echo "1. Confirmar accion."
		echo "2. Cancelar y volver al menu de gestion."
		read -p "Su opcion: " opcion
		if [ $opcion = 1 ]; then
			sudo userdel $nombre
			echo "Usuario borrado exitosamente."; echo ""
			echo "¿Desea tambien borrar el directorio de trabajo del usuario $nombre ?"
			ruta=$(cat /etc/passwd | cut -d ":" -f6 | grep $nombre)
			echo "El directorio se encuentra en la ruta: $ruta "
			read -p "1- Si / 2- No | Su opcion: " entrada
			case "$entrada" in
				1)
					sudo rm -r $ruta
					echo ""; echo "La carpeta personal se borro correctamente."
					echo "Regresando al menu de gestion de usuarios . . ."
					sleep 2;
					clear
					;;
				2)
					echo ""; echo "Regresando al menu de gestion de usuarios . . ."
					sleep 2;
					clear
					;;
				*)
					echo "Opcion invalida. Debe ingresar 1 o 2."	
					step 2;
					clear
					;;
			esac

		elif [ $opcion = 2 ]; then
			# cancelar
			echo ""
			echo "Volviendo al menu de gestion de usuarios . . ."
			sleep 2;
			clear
		else
			echo "Error: opcion Invalida."
			echo "Regresando al menu de gestion de usuarios . . ."
			sleep 2;
			clear
		fi
	fi # cierre del If -z $busqueda

}
##################################################################################################################

function modificarUsuario(){
	local nombre=""; local opcion=""; # Variables a usar
	local nuevoNombre="";

	echo ""
	read -p "Ingresar el nombre de usuario a modificar : " nombre
	local busqueda=$(getent passwd $nombre)

	if [ -z $busqueda ]; then
		#en caso de que no se encuentre el usuario en datos passwd

		echo "Error. No se encontro ningun usuario con el nombre de '$nombre'. "
		echo "Regresando al menu de gestion de usuarios . . ."
		sleep 2;
		clear
	else #caso que este todo bien:
		local opcion=null # variable para que usuario ingrese opcion a continuacion:

		while [ $opcion != 4 ]; do

			echo ""; echo "1. Modificar nombre del usuario $nombre"
			echo "2. Modificar contraseña del usuario $nombre"
			echo "3. Cambiar de Grupo"
			echo "4. Volver al menu de gestion de usuarios"
			read -p "Su opcion: " opcion

			case $opcion in
				1)
					# Opcion cambiar nombre
					read -p "Ingresar nuevo nombre para el usuario $nombre : " nuevoNombre
					if [ -z $nuevoNombre ]; then
						echo "Error. No ingresó el dato solicitado. Volviendo al menu de gestion."
						sleep 2;
						clear
					else
						sudo usermod -l $nuevoNombre $nombre  #cambiamos en nombre
						sudo usermod -d /home/$nuevoNombre $nuevoNombre -m # y tambien cambiamos de nombre su directorio personal
						echo ""
						echo "***********************************************"
						echo "Nombre modificado correctamente."
						echo "Nuevo nombre: $nuevoNombre"
						echo "Nueva ruta del directorio personal: /home/$nuevoNombre"
						echo ""; read -p "Presione una tecla para continuar . . ." var
						clear
					fi
					;;

				2)
					# cambiar password, el mismo comando muestra salida por consola y pide password nueva
					sudo passwd $nombre 
					echo ""; echo "Regresando al menu de gestion . . ."
					sleep 2;
					clear
					;;
				3) 
					# cambiar de grupo
					echo "";
					miGrupo=$(groups $nombre | cut -d ":" -f2) # obtengo nombre del grupo al que pertenecía
					echo "El usuario $nombre pertenece al grupo $miGrupo"
					echo "Ingresar nombre del grupo al que desea cambiar:"
					read nuevoGrupo
					# buscamos si el grupo ingresado existe, en /etc/group
					buscar=$(cat /etc/group | cut -d ":" -f1 | grep $nuevoGrupo);

					if [ -z $buscar ]; then
						#si no hay resultados, es porque no existe el grupo
						echo "No se encontro el grupo $nuevoGrupo en los registros del sistema"
						sleep 2;
					else
						# si efectivamente existe, le cambiamos el grupo al usuario:
						sudo usermod -g $nuevoGrupo $nombre 	# $nombre: es el nombre del usuario
						echo "Usuario cambiado correctamente al grupo $nuevoGrupo"
						sleep 2;
						clear;
					fi
					;;
					
				4)
					echo "Regresando al menu de gestion . . ."
					sleep 1;
					clear
					# salimos del while.
					;;
				*)
					echo "Error: $opcion no es una opcion valida"	
					sleep 2;
					clear
					;;
			esac
		done
	fi
}

### fin de declaraciones de funciones ##########################

# menu de Gestion de Usuarios - Comienza la visualizacion por consola
entrada=null #variable a usar en el While

while [ $entrada != 0 ]; do
	echo "***********************"
	echo "* Gestion de Usuarios *"
	echo "***********************"
	echo ""
	echo "(1) - Alta de Usuario"
	echo "(2) - Baja de Usuario"
	echo "(3) - Modificar Usuario"
	echo "(0) - Volver al inicio"
	read -p "Su opción: " entrada

	case "$entrada" in
		1)
			altaUsuario	#invocamos la funcion definida arriba
			;;

		2)
			bajaUsuario
			;;
		3)
			modificarUsuario
			;;
		0)
			echo "Volviendo al menu de gestion . . ."
			sleep 1;
			clear
			break  #salimos de la clausula del While
			;;

		*)
			echo "Error: $entrada no es una opcion valida."	
			sleep 2;
			clear
			;;
	esac
done


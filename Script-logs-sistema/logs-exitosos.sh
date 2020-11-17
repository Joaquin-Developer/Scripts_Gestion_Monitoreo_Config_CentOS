#!/bin/bash
clear
#### funciones a utilizar: ####################################

function porUsuario(){
	usuario=""
	read -p "Ingresar nombre de usuario para ver su registro de logins exitosos: " usuario
	busqueda=$(cat /etc/passwd | grep -i $usuario) # busco si existe el usuario ingresado
	if [ -z $busqueda ]; then
		echo "Error. El usuario ingresado no existe."
	else
		clear
		echo "Para navegar por el registro puede usar las teclas de navegacion."
		echo "Para salir presione la tecla q"
		read -p "Presione enter para ver registro . . ." entrada
		echo "Registro de logs del usuario $usuario" > /root/registros/logs-$usuario.txt # con > sobrescribo, con >> agrego
		echo "USUARIO              IP                Fecha      Hora          Duracion" >> /root/registros/logs-$usuario.txt 
		last | grep $usuario >> /root/registros/logs-$usuario.txt
		# OFS = Output Field Separatot ("  ")
		cat /root/registros/logs-$usuario.txt | less 	# mostramos archivo
	fi
}
###############################################################

function todos(){
	echo "Para navegar por el registro puede usar las teclas de navegacion."
	echo "Para salir presione la tecla q"
	read -p "Presione enter para acceder al registro de logs exitosos. " entrada
	last | less
}
##### fin declaracion de funciones #############################

echo "==========================================="
echo "=  REGISTRO DE LOGS EXITOSOS DEL SISTEMA  ="
echo "==========================================="
echo ""
echo "(1). Listar logs por usuario"
echo "(2). Ver todos los registros"
echo "(0). Volver"
echo ""
opcion=""
read -p "Su opcion: " opcion
case "$opcion" in
	1)
		porUsuario
		;;
	2)
		todos
		;;
	#0)
	#	;;
	*)
		;;
esac

read -p "Presione enter para volver al menu . . . " opcion
sleep 2
clear


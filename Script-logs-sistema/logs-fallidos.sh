#!/bin/bash
clear
#### funciones a utilizar: ####################################

function verPorUsuario(){
	usuario=""
	read -p "Ingresar nombre de usuario para ver su registro de logins fallidos: " usuario
	busqueda=$(cat /etc/passwd | grep -i $usuario) # busco si existe el usuario ingresado
	if [ -z $busqueda ]; then
		echo "Error. El usuario ingresado no existe."
	else
		clear
		echo "Para navegar por el registro puede usar las teclas de navegacion. Puede salir con la tecla q"
		read -p "Presione enter para ver registro . . ." entrada
		echo "Logs fallidos del usuario $usuario" > /root/registros/logs-fallidos-$usuario.txt # con > sobrescribo, con >> agrego
		echo "USUARIO              IP                Fecha      Hora          Duracion" >> /root/registros/logs-fallidos-$usuario.txt 
		lastb | grep $usuario >> /root/registros/logs-fallidos-$usuario.txt
		# OFS = Output Field Separatot ("  ")
		cat /root/registros/logs-fallidos-$usuario.txt | less 	# mostramos archivo
	fi
}
###############################################################

function verTodos(){
	echo "Para navegar por el registro puede usar las teclas de navegacion."
	echo "Para salir presione la tecla q"
	read -p "Presione enter para acceder al registro de logs exitosos. " entrada
	lastb | less
}
##### fin declaracion de funciones #############################

echo "==========================================="
echo "=  REGISTRO DE LOGS FALLIDOS DEL SISTEMA  ="
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
		verPorUsuario
		;;
	2)
		verTodos
		;;
	#0)
	#	;;
	*)
		;;
esac

read -p "Presione enter para volver al menu . . . " opcion
sleep 2
clear


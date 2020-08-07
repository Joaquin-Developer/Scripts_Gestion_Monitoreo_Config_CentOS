#!/bin/bash
clear


# borro fichero en caso de existir
busqueda=$(ls | grep "listaLogueados.txt")
if [ "$busqueda" != "" ]; then
	rm listaLogueados.txt
fi

# creo un archvo temporal, para guardar la salida del
# comando w en un archivo, y poder obtener datos con grep y sed
touch listaLogueados.txt

w | cut -d" " -f1 | grep -v "USUARIO" > listaLogueados.txt  # escribo salida de w en listaLogueados.txt

lineas=$(cat listaLogueados.txt | wc -l); # almaceno el total de lineas del archivo

# primer linea a mostrar = 2
# ultima linea a mostrar = $lineas

echo "Registro de usuarios logueados actualizado a la hora $(w | cut -d" " -f2)"
echo "";
for((i=2; i<= $lineas; i++)); do    # for tipo C en linux
	cont=$i"p"
	sed -n $cont listaLogueados.txt
done
echo ""; #linea en blanco

opcion="";
read -p "¿Desea guardar el registro de usuarios logueados a la hora $(w | cut -d" " -f2) ? ( si / no) : " opcion
case "$opcion" in
	"si"|"SI")
		# renombro el archivo para que quede con fecha y hora como nombre
		mv $(pwd)/listaLogueados.txt $(pwd)/listaLogueados-$(date +%d-%m-%H:%M).txt
		nuevoNombre="listaLogueados-$(date +%d-%m-%H:%M).txt"
		# luego, muevo el archivo a la carpeta de registros creada en /root
		mv $nuevoNombre /root/registros
		echo "Registro guardado en el archivo: /root/registros/$nuevoNombre"
		;;
	"no"|"NO")
		rm listaLogueados.txt # borro el archivo temporal
		echo "Volviendo al menu . . ."
		sleep 2
		clear
		;;
	*)
		rm listaLogueados.txt # borro el archivo temporal
		echo "Opcion invalida."
		echo "Volviendo al menu . . ."
		sleep 2
		clear
		;;
esac


#!/bin/bash
echo ""
echo ""
# obtengo estado del servicio cortando salida del comando systemctl status :
estadoMysql=$(systemctl status mariadb | grep -i "active" | cut -d":" -f2 | cut -d" " -f2 )

if [ "$estadoMysql" = "active" ]; then
        echo "El servicio MariaDB se encuentra activado"
else
        echo "El servicio MariaDB se encuentra desactivado"
fi
echo ""
read -p "Presione enter para volver al centro de computos . . . " entrada


#!/bin/bash
#ruta=/datos/Proyectos/Sql/menu/sql/
#ruta=/datos/Tools/OracleSqlScripts
ruta=$1
FILE=/tmp/ranger_$TOKEN



while true; do
    ranger --choosefile=$FILE $ruta
#    clear 
    echo "Script:"
    cat $FILE
    echo

    read -p "Quieres ejecutar este script?" yn
    case $yn in
        [YySs]* ) echo "@`cat $FILE`" > /tmp/menu_$TOKEN.sql; break;;
        [Nn]* ) echo;;
        * ) echo "Indica si/yes o no.";;
    esac
done




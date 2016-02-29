#!/bin/bash

# Token basado en el Pid del shell
export TOKEN=$$

base=/datos/Tools/Oracle_Instant_Client/
export ORACLE_HOME=$base/instantclient_11_2
export LD_LIBRARY_PATH=$ORACLE_HOME:$LD_LIBRARY_PATH
export TNS_ADMIN=$base/TNS_ADMIN

export SCRIPT_PATH=/datos/Tools/OracleSqlScripts/Scripts
export SCRIPT_OUTPUT=/tmp/oracle_spool

mkdir -p $SCRIPT_OUTPUT


SQ="$ORACLE_HOME/sqlplus"

CONX="$1"
shift


echo "Generando diccionario..."
time $SQ -S /nolog << EOF > /tmp/dict_$TOKEN
WHENEVER SQLERROR EXIT 1
connect $CONX
@$SCRIPT_PATH/helper/gen_dict.sql 
EOF

RC=$?

if [ "X$RC" != "X0" ]; then
	echo "Error en conexion o scripts de inicio!!!"
	cat /tmp/dict_$TOKEN
	rm /tmp/dict_$TOKEN
	exit 1
fi



echo "Conectando..."
rlwrap -f /tmp/dict_$TOKEN $SQ $CONX @$SCRIPT_PATH/helper/carga_entorno.sql $TOKEN $SCRIPT_OUTPUT

echo "Limpiando..."
rm -f /tmp/dict_$TOKEN /tmp/menu_$TOKEN /tmp/ranger_$TOKEN





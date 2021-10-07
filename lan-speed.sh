#!/bin/bash

figlet LAN Speed

# Se crea el archivo CSV y se agrega un título a la columna.
echo "Data" > data.csv

# El script tiene dos argmentos: la interfaz de monitoreo y la dirección ip4.
case $# in
	2)	
		# Presione cualquier tecla para salir del ciclo.
		while [ true ] ; do
			read -t 1 -n 1
			if [ $? = 0 ] ; then
				echo "Analizando datos...";
				break ;
			else
				# Print timestamp (unix time + microseconds as in gettimeofday) before each line.
				ping -A -c 300 -D -I $1 -i 1 $2 | cat | awk -F ' ' '{split($8,time,"="); print time[2]}' >> data.csv;
			fi
		done
		python3 analisis.py
		echo "Graficando datos...";
		eog plot.png
	;;
	*)
		echo "More than one argument is needed."
	;;
esac

#!/bin/bash

# Se crea el archivo CSV y se agrega un título a la columna.
echo "Data" > data.csv

# El script tiene dos argmentos: la interfaz de monitoreo y la dirección ip4.
case $# in
	2)
		# Print timestamp (unix time + microseconds as in gettimeofday) before each line.
		ping -A -D -I $1 -i 1 $2 | cat | awk -F ' ' '{split($8,time,"="); print time[2]}' >> data.csv
	;;
	*)
		echo "More than one argument is needed."
	;;
esac

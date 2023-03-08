#!/bin/bash

figlet LAN Speed

# Create a named pipe instead of a CSV file.
mkfifo ping_output

# The script has two arguments: the monitoring interface and the IPv4 address.
case $# in
	2)
		# Print timestamp (unix time + microseconds as in gettimeofday) before each line.
		ping -A -c 300 -D -I $1 -i 1 $2 | cat | awk -F ' ' '{split($8,time,"="); print time[2]}' > ping_output &

		# Wait for 1 second before running the Python script.
		sleep 1
		
		# Pipe the output of the ping command directly to the Python script.
		cat ping_output | python3 analisis.py

		# Remove the named pipe.
		rm ping_output

		# Display the plot using the default image viewer.
		echo "Graficando datos...";
		# eog plot.png;
	;;
	*)
		echo "Se necesita más de un argumento.";
	;;
esac
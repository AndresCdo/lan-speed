#!/bin/bash

figlet LAN Speed

# Create a named pipe in the /tmp directory.
PIPE=/tmp/ping_output
rm -f $PIPE
mkfifo $PIPE

# The script has two arguments: the monitoring interface and the ipv4 address.
case $# in
    2)
        # Press any key to exit the loop.
        while [ true ] ; do
            read -t 1 -n 1
            if [ $? = 0 ] ; then
                echo "Analyzing data..."
                break ;
            else
                # Append the ping output to the named pipe.
                ping -A -c 300 -D -I $1 -i 1 $2 | awk -F ' ' '{split($8,time,"="); print time[2]}' > $PIPE &
            fi
        done

        # Read the output from the named pipe and pipe it to the Python script.
        cat $PIPE | python analysis.py
        rm $PIPE
        #echo "Plotting data..."
        #eog plot.png
        ;;
    *)
        echo "More than one argument is needed."
        ;;
esac
#!/bin/bash

if [ ! $# -eq 0 ]; then
ping -A -D -I enp3s0 -i 1 $1 | cat | awk -F ' ' '{split($8,time,"="); print time[2]}' > data.csv
fi

#!/bin/bash

# Check if required dependencies are installed
check_dependencies() {
	local dependencies=("ping" "awk" "python3" "eog")
	for dep in "${dependencies[@]}"; do
		if ! command -v "$dep" >/dev/null 2>&1; then
			echo "Error: $dep is not installed. Please install it and try again."
			exit 1
		fi
	done
}

# Generate a filename based on the current date and time
generate_filename() {
	local timestamp=$(date +"%Y%m%d_%H%M%S")
	echo "data_$timestamp.csv"
}

# Handle command-line arguments
handle_arguments() {
	local interface ip

	while getopts ":i:a:" opt; do
		case $opt in
			i) interface=$OPTARG ;;
			a) ip=$OPTARG ;;
			\?) echo "Invalid option: -$OPTARG" >&2 ;;
		esac
	done

	if [[ -z $interface || -z $ip ]]; then
		echo "Usage: $0 -i <interface> -a <ip>"
		exit 1
	fi

	# Execute the main logic
	main_logic "$interface" "$ip"
}

# Main logic of the script
main_logic() {
	local interface=$1
	local ip=$2
	local csv_file=$(generate_filename)

	echo "Data" > "$csv_file"

	while true; do
		read -t 1 -n 1
		if [ $? = 0 ]; then
			echo "Analyzing data..."
			break
		else
			if ! ping_output=$(ping -A -c 300 -D -I "$interface" -i 1 "$ip" 2>/dev/null); then
				echo "Error: Failed to execute ping command."
				exit 1
			fi

			awk -F ' ' '{split($8,time,"="); print time[2]}' <<< "$ping_output" >> "$csv_file"
		fi
	done

	python3 analisis.py "$csv_file"
	rm "$csv_file"

	echo "Plotting data..."
	eog plot.png
}

# Entry point of the script
main() {
	check_dependencies
	handle_arguments "$@"
}

main "$@"

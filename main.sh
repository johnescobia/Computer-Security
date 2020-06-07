#!/bin/bash

# Import global functions and variables.
source ./src/global.sh

# Called when 'Display' is selected from the main menu.
start_display() {
	source ./src/display_content.sh
}

# Called when 'Analysis' is selected from the main menu.
start_analysis() {
	source ./src/do_analysis.sh
}

# Called when 'Encryption' or 'Decryption' is selected from the main menu.
start_cryptography() {
	continue=1

	while [ $continue -eq 1 ]
	do
		continue=0
		source ./src/set_filename.sh
		[[ $continue -eq 1 ]] && source ./src/set_keyword.sh
	done

	if [ ! -z ${KEYUNIQUE+x} ]; then
		source ./src/shift_cipher.sh $1 $KEYUNIQUE $FILE $KEYPOS
	fi
}

# Display the "MAIN-MENU".
display_main_menu() {
	clear
	printf "${BLUE} M A I N - M E N U ${STD}\n"
	printf "[1] Encryption\n"
	printf "[2] Decryption\n"
	printf "[3] Analysis\n"
	printf "[4] Display\n"
	printf "[5] Exit\n\n"
}

# Read input from the keyboard and call functions accordingly
# for the "MAIN-MENU".
read_main_options(){
	local choice
	printf "Enter choice [1 - 5]: "
	read choice
	case $choice in
		1) start_cryptography "E" ;;
		2) start_cryptography "D" ;;
		3) start_analysis ;;
		4) start_display ;;
		5) exit_program ;;
		*) error "$choice" "choice"
	esac
}

# Trap CTRL+C, CTRL+Z and quit singles
trap '' SIGINT SIGQUIT SIGTSTP

# START of the program.
# Loop the "MAIN-MENU".
while true
do
	display_main_menu
	read_main_options
done

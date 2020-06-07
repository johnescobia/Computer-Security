# END of get file function.
# Get input and searches the directory for it.
# If found, exit current loop. If not found, show error.
find_file() {
	printf "Enter filename: "
	read FILE

	if [ -f ./test_files/$FILE ]; then
		continue=1
		break_loop
	else
		error "$FILE" "filename"
		unset FILE
	fi
}

# Display the "SET-FILENAME" menu.
display_get_file_menu() {
	clear
	printf "${BLUE} S E T - F I L E N A M E ${STD}\n"
	printf "[1] Enter filename\n"
	printf "[2] Back\n"
	printf "[3] Exit\n\n"
}

# Read input from the keyboard and call functions accordingly
# for the "SET-FILENAME" menu.
read_get_file_options() {
	local choice
	printf "Enter choice [1 - 3]: "
	read choice
	case $choice in
		1) find_file ;;
		2) break_loop continue=0 ;;
		3) exit_program ;;
		*) error "$choice" "choice"
	esac
}

# START of get file function.
# Loop the "SET-FILENAME" menu.
while true
do 
	display_get_file_menu
	read_get_file_options
	if [[ $break -eq 1 ]]; then
		break=0
		break
	fi
done

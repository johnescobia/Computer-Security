# END of display content function.
# Display content of file
display_content() {
	clear
	printf "`cat $1`\n\n"
	pause	
}

# Get input and searches the directory for it.
# If found, display its content. If not found, show error.
find_file() {
	local FILENAME
	printf "Enter filename: "
	read FILENAME

	if [ -f ./test_files/$FILENAME ]; then
		display_content ./test_files/$FILENAME
	else
		error "$FILENAME" "filename"
		unset FILENAME
	fi
}

# Display the "DISPLAY-CONTENT" menu.
display_content_menu() {
	clear	
	printf "${BLUE} D I S P L A Y - C O N T E N T ${STD}\n"
	printf "[1] Enter filename\n"
	printf "[2] Back\n"
	printf "[3] Exit\n\n"
}

# Read input from the keyboard and call functions accordingly
# for the "DISPLAY-CONTENT" menu.
read_display_options() {
	local choice
	printf "Enter choice [1 - 3]: "
	read choice
	case $choice in
		1) find_file ;;
		2) break_loop ;;
		3) exit_program ;;
		*) error "$choice" "choice"
	esac
}

# START of display content function.
# Loop the "DISPLAY-CONTENT" menu. 
while true
do
	display_content_menu
	read_display_options
	if [[ $break -eq 1 ]]; then
		break=0
		break
	fi
done

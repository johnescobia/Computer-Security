# END of set keyword function.
# Assign variables accordingly and call break_loop().
place_key() {
	KEYPOS="$1"
	continue=0
	break_loop
}

# Display the "KEYWORD-POSITION" menu.
display_set_key_pos_menu() {
	clear
	printf "${BLUE} K E Y W O R D - P O S I T I O N ${STD}\n"
	printf "[1] Insert in front\n"
	printf "[2] Append at the end\n"
	printf "[3] Back\n"
	printf "[4] Exit\n\n"
}

# Read input from the keyboard and call functions accordingly
# for the "KEYWORD-POSITION" menu.
read_set_key_pos_options() {
	local choice
	printf "Enter choice [1 - 4]: "
	read choice
	case $choice in
		1) place_key "FRONT" ;;
		2) place_key "BACK" ;;
		3) break_loop ;;
		4) exit_program ;;
		*) error "$choice" "choice"
	esac
}

# Loop the "KEYWORD-POSITION" menu.
loop_set_key_pos() {
	while true
	do 
		display_set_key_pos_menu
		read_set_key_pos_options
		if [[ $break -eq 1 ]]; then
			[ -z ${KEY+x} ] && break=0 || break_loop
			unset KEY
			break
		fi
	done
}

# Check if there is an existing keyword.
# If there is none, display a warning.
# Otherwise, proceed to loop the "KEYWORD-POSITION" menu.
reuse_key() {
	if [ -z ${KEYUNIQUE+x} ]; then
		printf "${YELLOW} WARNING: No reusable keyword found. Select [1]. ${STD}\n"
		pause
	else
		loop_set_key_pos
	fi
}

# Check if keyword has at least 5 unique characters.
# If false, go back to "SET_KEYWORD" menu.
# If true, proceed to the "KEYWORD-POSITION" menu.
check_unique_char() {
	# Remove repeating characters in the key
	KEY=$(awk -v FS="" '{
		for(n=1;n<=NF;n++)
		strg=(++a[$n]==1?strg $n:strg)
		} END {print strg}' <<< "$KEY")

	if [ ${#KEY} -lt 5 ]; then
		printf "${YELLOW} 5 unique characters or more is required in the keyword. ${STD}\n"
		unset KEY
		pause
	else
		KEYUNIQUE=`echo $KEY | tr [:lower:] [:upper:]`
		loop_set_key_pos
	fi
}

# Read input from keyboard and check that input for unique characters.
get_key() {
	printf "Enter keyword: "
	read KEY
	
	check_unique_char
}

# Display the "SET-KEYWORD" menu
display_set_key_menu() {
	clear
	printf "${BLUE}     S E T - K E Y W O R D     ${STD}\n"
	printf "[1] Enter new keyword\n"
	printf "[2] Reuse previous keyword\n"
	printf "[3] Back\n"
	printf "[4] Exit\n\n"
}

# Read input from the keyboard and call functions accordingly
# for the "SET_KEYWORD" menu
read_set_key_options() {
	local choice
	printf "Enter choice [1 - 4]: "
	read choice
	case $choice in
		1) get_key ;;
		2) reuse_key ;;
		3) break_loop ;;
		4) exit_program ;;
		*) error "$choice" "choice"
	esac
}

# START of set keyword function.
# Loop the "SET-KEYWORD" menu
while true
do
	if [[ $break -eq 1 ]]; then
		break=0
		break
	fi
	display_set_key_menu
	read_set_key_options
done

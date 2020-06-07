# END of analysis function.
do_analysis() {
	# Store total characters in the file
	total=`cat $1$2 | wc -c`

	# Initialize a new file
	new="$1a.$2"
	echo "" > $new

	# Loop through all alphabets in the English language
	for i in {A..Z}
	do
		# Get number of occurences of each alphabet
		char=`cat $1$2 | tr [:lower:] [:upper:] | grep -o $i | wc -l`

		# Get percentage of each letter
		percent=`echo "scale=4;($char/$total)*100" | bc -l`

		# Print total occurences, percentage and name of alphabet to the file
		printf "%10d %11f %8s\n" $char $percent $i >> $new
	done

	# Sort the percentage and name pair of alphabet in descending order
	sort -n -r $new -o $new

	# Get file's content and make the file empty.
	# Afterwards, insert headings to the empty file
	# and paste back its previous contents.
	a="$(cat $new)"
	> $new
	printf "%10s %11s %8s\n" TOTAL PERCENTAGE LETTER >> $new
	echo "$a" >> $new
}

# Get input for file and searches the directory for it.
# If found, do analysis on the file. If not found, show error.
find_file() {
	local FILENAME
	printf "Enter filename: "
	read FILENAME

	if [ -f ./test_files/$FILENAME ]; then
		do_analysis "./test_files/" "$FILENAME"
	else
		error "$FILENAME" "filename"
		unset FILENAME
	fi
}

# Dislay the "ANALYSIS" menu.
display_analysis_menu() {
	clear	
	printf "${BLUE}    A N A L Y S I S    ${STD}\n"
	printf "[1] Enter filename\n"
	printf "[2] Back\n"
	printf "[3] Exit\n\n"
}

# Read input from the keyboard and call functions accordingly
# for the "ANALYSIS" menu.
read_analysis_options() {
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

# START of analysis function.
# Loop the "ANALYSIS" menu.
while true
do
	display_analysis_menu
	read_analysis_options
	if [[ $break -eq 1 ]]; then
		break=0
		break
	fi
done

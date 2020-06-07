# Functions and variables that are used/called in all files.

# Foreground and background color variables
BLUE='\033[0;104;30m'
YELLOW='\033[0;43;30m'
RED='\033[0;41;30m'
STD='\033[0;0;39m'

# Clears terminal and exit the program
exit_program() {
	clear
	exit
}

# Pauses the program until [Enter] key pressed
pause() {
	read -p "Press [Enter] to continue..." fackEnterKey
}

# Handles errors 
error() {	
	if [ -z "$1" ]; then
		printf "${RED} No $2 entered ${STD}\n"
	else
		if [ "$2" == "choice" ]; then
			printf "${YELLOW} $1 is not a valid $2 ${STD}\n"
		else
			printf "${YELLOW} $1 does not exist ${STD}\n"
		fi
	fi
	pause
}

# Assigns $break=1
# Called mainly to exit child loop without exiting parent loop
break_loop() {
	break=1
}

# END of shift cipher.
# Loop through $CONTENT and store it in $LINE.
# For every newline detected, perform shift cipher on $LINE.
# $LINE is empty after every shift cipher operation.
operate_line() {
	LINE=''
	for((k=0;k<=$CONTENTLEN;k++))
	do
		[ "${CONTENT:k:1}" != $'\n' ] && LINE+="${CONTENT:k:1}" || shift_cipher
	done

	# For the last line
	shift_cipher
}

# Count number of newlines in $FILE
count_line() {
	CONTENT=`awk '{print}' ./test_files/$FILE`
	CONTENTLEN=${#CONTENT}
	NLCOUNT=0
    
	for((a=0;a<$CONTENTLEN;a++))
	do
		# Increase NLCOUNT by 1 when a newline is detected
		[ "${CONTENT:a:1}" == $'\n' ] && ((NLCOUNT++))
	done
}

# Remove repeating characters in $KEY from $P
# and concatenate both according to $POS.
make_key() {
	P="ABCDEFGHIJKLMNOPQRSTUVWXYZ"

	if [ $POS == 'FRONT' ]; then
		KEYFINAL=$KEY${P//[$KEY]/}
	else
		KEYFINAL=${P//[$KEY]/}$KEY
	fi
}

# Do mapping of $P <---> $KEYFINAL on $LINE and store in $OUTPUT.
# When end of file is reached, paste $OUTPUT to a file with the
# same name of $FILE and add a prefix of 'e.' for encryption or
# 'd.' for decryption.
shift_cipher() {
	# Do the substitution
	if [ $TYPE == "E" ]
	then
		OUTPUT+=`echo "$LINE" | tr [:lower:] [:upper:] | tr $P $KEYFINAL`
	else
		OUTPUT+=`echo "$LINE" | tr [:lower:] [:upper:] | tr $KEYFINAL $P`
	fi

	if [[ $NLCOUNT -ne 0 ]]
	then
		((NLCOUNT--))
		OUTPUT+=$'\n'
		unset LINE
	else
		# Paste OUTPUT to a file
		[ $TYPE == "E" ] && echo "$OUTPUT" > ./test_files/e.$FILE || echo "$OUTPUT" > ./test_files/d.$FILE
		unset OUTPUT
	fi
}

# START of shift cipher.
# Assign variables and execute functions from top to bottom.
TYPE=$1
KEY=$2
FILE=$3
POS=$4

make_key
count_line
operate_line

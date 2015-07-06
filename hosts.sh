#!/bin/bash

# This script updates the hosts file from the someonewhocares.org website.
# It is designed to work with the Mac OS X app Gasmask - https://github.com/2ndalpha/gasmask.

# VARIABLES
LOG_FILE=$PWD"/log.txt"
URL="http://someonewhocares.org/hosts/hosts"
GASMASK_FILE="$PWD/gasmask/SomeoneWhoCares.hst"

# WRITE HEADER TO LOG FILE
echo "=================================" 								> $LOG_FILE
echo " Updating hosts file"												>> $LOG_FILE
echo " " 																>> $LOG_FILE
echo " Starting at `eval date +%c`" 									>> $LOG_FILE
echo "=================================" 								>> $LOG_FILE

# Back up the old hosts file
echo "Backing up Gas Mask file"											>> $LOG_FILE
echo "cp -fv $GASMASK_FILE $PWD/old_hosts.txt"							>> $LOG_FILE
cp -fv $GASMASK_FILE $PWD/old_hosts.txt									>> $LOG_FILE 2>>$LOG_FILE

# Get the latest hosts text file
/opt/local/bin/wget --output-document=$PWD/hosts.txt --append-output=$LOG_FILE $URL

# Verify that we have an old_hosts.txt file
if [ -e $PWD/old_hosts.txt ]; then
	# Compare latest hosts file to the previous one
	echo "Comparing old hosts file to newly downloaded one"				>> $LOG_FILE
	diff $PWD/hosts.txt $PWD/old_hosts.txt | tee -a $LOG_FILE $PWD/diff.output
	DIFF_SIZE=$(stat -f %z $PWD/diff.output)
	rm $PWD/diff.output
	if [ "$DIFF_SIZE" = "0" ]; then
		echo "No difference in hosts.txt file, exiting"					>> $LOG_FILE
		exit 0;
	fi
fi

# COPY NEW FILE TO GASMASK DIRECTORY
echo "Copying new file to Gas Mask directory"							>> $LOG_FILE
echo "cp -f -v $PWD/hosts.txt $GASMASK_FILE"							>> $LOG_FILE
cp -f -v $PWD/hosts.txt $GASMASK_FILE									>> $LOG_FILE 2>>$LOG_FILE

#!/bin/bash

# This script updates the hosts file from the someonewhocares.org website.

# VARIABLES
LOG_FILE=$PWD"/log.txt"
URL="http://someonewhocares.org/hosts/hosts"

# WRITE HEADER TO LOG FILE
echo "=================================" 								> $LOG_FILE
echo " Updating hosts file"												>> $LOG_FILE
echo " " 																>> $LOG_FILE
echo " Starting at `eval date +%c`" 									>> $LOG_FILE
echo "=================================" 								>> $LOG_FILE

# Back up the old hosts file
mv $PWD/hosts.txt $PWD/old_hosts.txt

# Get the latest hosts text file
wget --output-document=$PWD/hosts.txt --append-output=$LOG_FILE $URL

# Verify that we have an old_hosts.txt file
if [ -e $PWD/old_hosts.txt ]; then
	# Compare latest hosts file to the previous one
	echo "Comparing old hosts file to newly downloaded one"				>> $LOG_FILE
	diff $PWD/hosts.txt $PWD/old_hosts.txt | tee -a $LOG_FILE $PWD/diff.output
	DIFF_SIZE=$(stat -c %s $PWD/diff.output)
	rm $PWD/diff.output
	if [ "$DIFF_SIZE" = "0" ]; then
		echo "No difference in hosts.txt file, exiting"					>> $LOG_FILE
		exit 0;
	fi
fi

# Strip out localhost / broadcasthost lines
cat $PWD/hosts.txt | sed '/*localhost/d' | sed '/.*local/d' | sed '/.*broadcasthost/d' > $PWD/trimmedHosts.txt

 # Create new hosts file by combining contents in local_hosts and the trimmed hosts file
cat $PWD/local_hosts													>> $PWD/hosts
cat $PWD/trimmedHosts.txt 												>> $PWD/hosts

# Delete the trimmed hosts file when we're done with it
rm $PWD/trimmedHosts.txt
	
# Backup the old hosts file
echo "Backing up the old hosts file"									>> $LOG_FILE
cp -v /etc/hosts $PWD/old-etc-hosts										>> $LOG_FILE 2>>$LOG_FILE

# Replace the hosts file
echo "Replacing the old hosts file"										>> $LOG_FILE
mv -v $PWD/hosts /etc/hosts												>> $LOG_FILE 2>>$LOG_FILE

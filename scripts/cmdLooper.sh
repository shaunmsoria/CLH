#!/bin/bash

# Lunch the file as instructed below:
# ./cmdLooper.sh ./tmp

# example docker ps -aq --filter 'status=exited' --filter 'status=created'

echo "please specify the command you want to execute on all item contained in the argument file"
echo "Example: docker rm -f"

read command

for i in $(cat $1)
	do
		echo "Applying $command to $i"
		$($command $i)
	done


#!/bin/bash

#specify the containerIDs to be remove -f
#example docker ps -aq --filter 'status=exited' --filter 'status=created'

echo "Welcome to the command looper"
echo "Please specify a command to select required items"
echo "Example: docker ps -aq --filter status=exited --filter status=created"
echo "Example: docker images -aq --filter=reference='*:latest'"

read filter

echo "Thank you"
echo "Now please specify a command that will be applied to all selected items"
echo "Example: docker rm -f"

read command

for i in $($filter)
	do 
		echo "Applying command to $i"
		$($command $i)
	done



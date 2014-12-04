#!/bin/bash

# Check if ports are running!
# Made by Pierre Zemb

# Declaration of services running on the hsot
Service_name=(sshd nginx);

# Declaration of services running into containers
Container_name=(cadvisor shout ghost);


# Definition of the colors
neutre='\e[0;m'
rougefonce='\e[0;31m'
vertclair='\e[1;32m'

echo;
echo "Is everything OK boss ?"
echo;
# Start looping for services
for i in "${Service_name[@]}"; do
	netstat -tulpn | grep $i > /dev/null;
	if [[ $? -eq 0 ]]; then
		printf "%-20s [${vertclair}running${neutre}]\n" "$i";
	else
		printf "%-20s [${rougefonce}not running${neutre}]\n" "$i";
	fi
done

# Start looping for docker's container
for i in "${Container_name[@]}"; do
	docker ps -a | grep $i  > /dev/null
	if [[ $? -eq 0 ]]; then
		printf "%-20s [${vertclair}running${neutre}]\n" "$i"
	fi
	if [[ $? -eq 1 ]]; then
		printf "%-20s [${rougefonce}not running${neutre}]\n" "$i"
	fi
done
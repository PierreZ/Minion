#!/bin/bash

# Check if ports are running!
# Made by Pierre Zemb

# Declaration of services running on the hsot
Service_name=(sshd nginx);

# Declaration of services running into containers
Container_name=(shout ghost elementz);

# Declaration of git
git_repo=('/srv/http/slides/docker-presentation-gdg-2014' '/srv/http/portfolio');

# Definition of the colors
neutre='\e[0;m'
rougefonce='\e[0;31m'
vertclair='\e[1;32m'

echo;
echo "There's $(checkupdates|wc -l) update(s) available"
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
echo;
echo "What about docker?";
echo;
# Start looping for docker's container
for i in "${Container_name[@]}"; do
	docker ps | grep $i  > /dev/null
	if [[ $? -eq 0 ]]; then
		printf "%-20s [${vertclair}running${neutre}]\n" "$i";
	else
		printf "%-20s [${rougefonce}not running${neutre}]\n" "$i";
		echo -e "${rougefonce}trying to start $i ${neutre}";
		docker start $i > /dev/null;
		if [[ $? -eq 0 ]]; then
			echo -e "${vertclair}$i is running!${neutre}";
		else
			echo -e "${rougefonce}$i is not running!${neutre}";
		fi
	fi
done

echo;
echo "Updating GitHub repos";
for repo in "${git_repo[@]}"; do
    echo "${repo}"
    (cd "${repo}" && git pull)
done

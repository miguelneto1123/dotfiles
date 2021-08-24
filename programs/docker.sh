#!/bin/bash

cd "$(dirname "$0")/.."
REPO_ROOT="$(pwd -P)"

# Get logging functions
source ./logger.sh

reply="y"
[ "$1" = "-f" ] || [ "$1" = "-y" ] || [ "$1" = "--force" ] || \
	read -p "$(user "Do you wish to install Docker? (y/n)")" -n 1 reply

case $reply in
	[Yy] )
		info "Downloading and installing Docker"
		sudo apt-get update
		sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
		curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
		echo \
			"deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
			$(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
		sudo apt-get update
		sudo apt-get install docker-ce docker-ce-cli containerd.io
		success "Docker was installed" ;;
	* )
		fail "Skipped Docker installation" ;;
esac
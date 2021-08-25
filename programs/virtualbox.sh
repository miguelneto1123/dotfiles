#!/bin/bash

cd "$(dirname "$0")/.."
REPO_ROOT="$(pwd -P)"

# Get logging functions
source ./logger.sh

reply="y"
[ "$1" = "-f" ] || [ "$1" = "-y" ] || [ "$1" = "--force" ] || \
	read -p "$(user "Do you wish to install Virtualbox? (y/n)")" -n 1 reply

case $reply in
	[Yy] )
		info "Downloading and installing Virtualbox"
		sudo apt-get update
		sudo apt-get install apt-transport-https ca-certificates gnupg lsb-release
		echo \
			"deb [arch=amd64] https://download.virtualbox.org/virtualbox/debian \
			$(lsb_release -cs) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list > /dev/null
		wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
		wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
		sudo apt-get update
		sudo apt-get install virtualbox-6.1
		success "Virtualbox was installed" ;;
	* )
		fail "Skipped Virtualbox installation" ;;
esac
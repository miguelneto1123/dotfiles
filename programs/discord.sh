#!/bin/bash

cd "$(dirname "$0")/.."
REPO_ROOT="$(pwd -P)"

# Get logging functions
source ./logger.sh

reply="y"
[ "$1" = "-f" ] || [ "$1" = "-y" ] || [ "$1" = "--force" ] || \
	read -p "$(user "Do you wish to install Discord? (y/n)")" -n 1 reply

case $reply in
	[Yy] )
		info "Downloading and installing Discord"
		wget -O discord.deb 'https://discord.com/api/download?platform=linux&format=deb'
		sudo dpkg -i discord.deb
		rm discord.deb
		success "Discord was installed" ;;
	* )
		fail "Skipped Discord installation" ;;
esac
!#/bin/bash

# This script installs the apt packages and handles program installations
# inside the programs directory

cd "$(dirname "$0")"
REPO_ROOT="$(pwd -P)"

# Getting logging functions
source ./logger.sh

install () {
	which $1 &> /dev/null

	flag=
	([ "$2" = "-y" ] || [ "$2" = "-f" ] || [ "$2" = "--force" ]) && flag="-y"

	if [ $? -ne 0 ]; then
		info "Installing: ${1}..."
		sudo apt-get install $flag $1
	else
		info "Already installed: ${1}"
	fi
}

# Installing apt packages
sudo apt-get update
install adwaita-icon-theme-full $1
install brave-browser $1
install build-essential $1
install curl $1
install make $1
install tree $1
install wget $1

# Installing the programs
for script in programs/*.sh; do bash "$script" $1; done

# Final update, upgrade and remove
sudo apt-get update
sudo apt-get upgrade
sudo apt-get autoremove
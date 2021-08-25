!#/bin/bash

# This script installs the apt packages and handles program installations
# inside the programs directory

cd "$(dirname "$0")"
REPO_ROOT="$(pwd -P)"

# Getting logging functions
source ./logger.sh

install () {
	which $1 &> /dev/null

	if [ $? -ne 0 ]; then
		info "Installing: ${1}..."
		sudo apt-get install $1
	else
		info "Already installed: ${1}"
	fi
}

# Installing apt packages
install adwaita-icon-theme-full
install brave-browser
install build-essential
install curl
install make
install tree
install wget

# Installing the programs
for script in programs/*.sh do bash "$script" $1; done

# Final update, upgrade and remove
sudo apt-get update
sudo apt-get upgrade
sudo apt-get autoremove
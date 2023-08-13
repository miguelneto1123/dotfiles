#!/bin/bash

# This script installs the apt packages and handles program installations
# inside the programs directory

cd "$(dirname "$0")"
REPO_ROOT="$(pwd -P)"

# Getting logging functions
source ./logger.sh

install () {
	local flag=
	([ "$2" = "-y" ] || [ "$2" = "-f" ] || [ "$2" = "--force" ]) && flag="-y"

	which $1 &> /dev/null

	if [ $? -ne 0 ]; then
		info "Installing: ${1}..."
		sudo apt-get install $flag $1
	else
		info "Already installed: ${1}"
	fi
}

forced=
([ "$1" = "-y" ] || [ "$1" = "-f" ] || [ "$1" = "--force" ]) && forced="-y"

# Installing apt packages
sudo apt-get update
sudo apt-get upgrade $forced
install tree $forced
install wget $forced # probably came with the system

# Installing the programs
for script in programs/*.sh; do bash "$script" $forced; done

# Final update, upgrade and remove
sudo apt-get update
sudo apt-get upgrade $forced
sudo apt-get autoremove $forced
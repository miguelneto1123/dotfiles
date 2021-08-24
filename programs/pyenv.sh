#!/bin/bash

cd "$(dirname "$0")/.."
REPO_ROOT="$(pwd -P)"

# Get logging functions
source ./logger.sh

reply="y"
[ "$1" = "-f" ] || [ "$1" = "-y" ] || [ "$1" = "--force" ] || \
	read -p "$(user "Do you wish to install pyenv for version management? (y/n)")" -n 1 reply

case $reply in
	[Yy] )
		git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
		success "pyenv was installed" ;;
	* )
		fail "Skipped pyenv installation" ;;
esac
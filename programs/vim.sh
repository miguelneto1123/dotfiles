#!/bin/bash

cd "$(dirname "$0")/.."
REPO_ROOT="$(pwd -P)"

# Get logging functions
source ./logger.sh

reply=

( [ "$1" = "-f" ] || [ "$1" = "-y" ] || [ "$1" = "--force" ] ) && reply="y"

[ -n "$(which vim)" ] && [ "$1" != "-f" ] && \
	[ "$1" != "-y" ] && [ "$1" != "--force" ] && \
	read -p "$(user "Vim is already installed. Do you want to compile the most recent version? (y/n)")" -n 1 reply

# [Nn] means user has it and won't recompile
# [Yy] means user has it and will recompile or is forcing installation
[ "$reply" = "n" ] || [ "$reply" = "N" ] || \
	[ "$reply" = "y" ] || [ "$reply" = "Y" ] || \
	[ "$1" = "-f" ] || [ "$1" = "-y" ] || [ "$1" = "--force" ] || \
	read -p "$(user "Do you wish to install Vim? (y/n)")" -n 1 reply

case $reply in
	[Yy] )
		info "Installing Vim..."
		sudo apt-get install -y build-essential libncurses5-dev libx11-dev libxtst-dev libxt-dev libsm-dev libxpm-dev
		cd $HOME
		git clone https://github.com/vim/vim.git
		cd vim/src
		make distclean
		./configure --with-features=huge
		make
		sudo make install
		success "Vim was installed" ;;
	* )
		fail "Skipped Vim installation" ;;
esac
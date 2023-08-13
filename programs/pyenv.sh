#!/bin/bash

cd "$(dirname "$0")/.."
REPO_ROOT="$(pwd -P)"

# Get logging functions
source ./logger.sh

reply="y"
[ "$1" = "-f" ] || [ "$1" = "-y" ] || [ "$1" = "--force" ] || \
	read -p "$(user 'Do you wish to install pyenv for Python version management? (y/n)')" -n 1 reply

case $reply in
	[Yy] )
		git clone https://github.com/pyenv/pyenv.git $HOME/.pyenv
		success "pyenv was installed. It will be available at next login"
		if [ -e ~/.bash_completion -a -e ~/.exports ]
		then
			ans="y"
			[ "$1" = "-f" ] || [ "$1" = "-y" ] || [ "$1" = "--force" ] || \
				read -p "$(user 'Do you want to add pyenv and pip bash completion and pyenv to PATH? (Y/n)')" -n 1 ans
			case $ans in
				[yY] )
					cat ./templates/pyenv-bash.template >> ~/.bash_completion
					cat ./templates/pyenv-exports.template >> ~/.exports
					success "Added to PATH and to bash completions" ;;	
				* )
					info "Make sure to add them manually if needed" ;;
			esac
		else
			info "Make sure to add initialization for pyenv on your .profile and shell .rc"
		fi ;;
	* )
		fail "Skipped pyenv installation" ;;
esac
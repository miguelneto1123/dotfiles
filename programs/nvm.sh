#!/bin/bash

cd "$(dirname "$0")/.."
REPO_ROOT="$(pwd -P)"

# Get logging functions
source ./logger.sh

get_latest_release () {
  wget -q -O - "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

reply="y"
[ "$1" = "-f" ] || [ "$1" = "-y" ] || [ "$1" = "--force" ] || \
	read -p "$(user 'Do you wish to install NVM for node.js version management? (y/n)')" -n 1 reply

case $reply in
	[Yy] )
		# Get github latest version
		latest="$(get_latest_release "nvm-sh/nvm")"
		# Run the install script
		wget -q -O - "https://raw.githubusercontent.com/nvm-sh/nvm/$latest/install.sh" | bash
		# Remove any changes made to ~/.bashrc
		git checkout -q "$REPO_ROOT/dotfiles/bash/.bashrc"
		success "NVM was installed. Make sure to run installation for both Node.js and npm after reboot"
		if [ -e ~/.bash_completion -a -e ~/.exports ]
		then
			ans="y"
			[ "$1" = "-f" ] || [ "$1" = "-y" ] || [ "$1" = "--force" ] || \
				read -p "$(user 'Do you want to add nvm and npm bash completion and NVM to PATH? (Y/n)')" -n 1 ans
			case $ans in
				[yY] )
					cat ./templates/nvm-bash.template >> ~/.bash_completion
					cat ./templates/nvm-exports.template >> ~/.exports
					success "Added to PATH and to bash completions" ;;
				* )
					info "Make sure to add them manually if needed" ;;
			esac
		fi ;;
	* )
		fail "Skipped NVM installation" ;;
esac
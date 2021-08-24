#!/bin/sh

cd "$(dirname "$0")/.."
REPO_ROOT="$(pwd -P)"

# Get logging functions
source ./logger.sh

get_latest_release () {
  curl --silent "https://api.github.com/repos/$1/releases/latest" | # Get latest release from GitHub api
    grep '"tag_name":' |                                            # Get tag line
    sed -E 's/.*"([^"]+)".*/\1/'                                    # Pluck JSON value
}

reply="y"
[ "$1" = "-f" ] || [ "$1" = "-y" ] || [ "$1" = "--force" ] || \
	read -p "$(user "Do you wish to install NVM, node.js and npm? (y/n)")" -n 1 reply

case $reply in
	[Yy] )
		# Get github latest version
		latest="$(get_latest_release "nvm-sh/nvm")"
		# Run the install script
		curl -o- "https://raw.githubusercontent.com/nvm-sh/nvm/$latest/install.sh" | bash
		# Remove any changes made to ~/.bashrc
		git checkout -q "$REPO_ROOT/dotfiles/bashrc"

		source ~/.bashrc
		nvm install node
		nvm install-latest-npm
		success "NVM, node.js and npm were installed" ;;
	* )
		fail "Skipped NVM installation" ;;
esac
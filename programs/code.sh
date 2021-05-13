#!/bin/bash

cd "$(dirname "$0")/.."
REPO_ROOT="$(pwd -P)"
CODE_CONFIG="$REPO_ROOT/.config/Code"

install_ext () {
	code --install-extension "$1" --force
}

reply="y"
[ "$1" = "-f" ] || [ "$1" = "-y" ] || [ "$1" = "--force" ] || \
	read -p "Do you wish to install VSCode? (y/n)" -n 1 reply

case $reply in
	[Yy] )
		echo -e "\nInstalling VSCode..."
		wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
		sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
		sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
		rm -f packages.microsoft.gpg
		sudo apt install -y apt-transport-https
		sudo apt update
		sudo apt install code
		echo "Installed VSCode"
		echo "Installing extensions..."
		for ext in $(< "$CODE_CONFIG"/extensions); do
			install_ext "$ext"
		done
		echo "Installed extensions"
		echo "Copying keybinds..."
		rm $HOME/.config/Code/User/*.json
		ln -s $CODE_CONFIG/keybindings.json $HOME/.config/Code/User/keybindings.json
		ln -s $CODE_CONFIG/settings.json $HOME/.config/Code/User/settings.json
		echo -e "Copied keybinds\nVSCode done"
		;;
	* )
		echo -e "\nSkipped VSCode installation"
esac

#!/bin/bash

cd "$(dirname "$0")"
REPO_ROOT="$(pwd -P)"
DOTFILES_ROOT="$REPO_ROOT/dotfiles"

# Get logging functions
source ./logger.sh

link_file () {
	local src=$1 dst=$2

	local overwrite= backup= skip=
	local action=

	if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
	then

		if [ "$overwrite_all" != "true" ] && [ "$backup_all" != "true" ] && [ "$skip_all" != "true" ]
		then

			local currentSrc="$(readlink $dst)"

			if [ "$currentSrc" == "$src" ]
			then

				skip=true;

			else

				user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
				[s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
				read -n 1 action

				case "$action" in
					o )
						overwrite=true ;;
					O )
						overwrite_all=true ;;
					b )
						backup=true ;;
					B )
						backup_all=true ;;
					s )
						skip=true ;;
					S )
						skip_all=true ;;
					* )
						;;
				esac

			fi

		fi

		overwrite=${overwrite:-$overwrite_all}
		backup=${backup:-$backup_all}
		skip=${skip:-$skip_all}

		if [ "$overwrite" == "true" ]
		then
			rm -rf "$dst"
			success "removed $dst"
		fi

		if [ "$backup" == "true" ]
		then
			mv "$dst" "${dst}.bak"
			success "moved $dst to ${dst}.bak"
		fi

		if [ "$skip" == "true" ]
		then
			success "skipped $src"
		fi

	else

		if [ "$copy_all" != "true" ] && [ "$skip_all" != "true" ]
		then

			user "File $dst does not exist, what do you want to do?\n\
				[c]opy from repo, [C]opy all from repo, [s]kip, [S]kip all?"
			read -n 1 action
			
			case "$action" in
				C )
					copy_all=true ;;
				s )
					skip=true ;;
				S )
					skip_all=true ;;
				* )
					;;
			esac

		fi

    skip=${skip:-$skip_all}
    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi

	fi

	if [ "$skip" != "true" ]	# "false" or empty
	then
		if [ "$(basename $src)" == ".bashrc" ]
		then
			cp $REPO_ROOT/templates/bash_completion.template $HOME/.bash_completion
		elif [ "$(basename $src)" == ".profile" ]
		then
			cp $REPO_ROOT/templates/path.template $HOME/.path
			cp $REPO_ROOT/templates/exports.template $HOME/.exports
		fi
		ln -s "$1" "$2"
		success "linked $1 to $2"
	fi
}

install_dotfiles() {
	for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -type f); do
		dst="$HOME/$(basename "${src}")"
		link_file $src $dst
	done
}

([ "$1" = "-y" ] || [ "$1" = "-f" ] || [ "$1" = "--force" ]) && overwrite_all="true" && copy_all="true"

install_dotfiles
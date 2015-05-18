#!/bin/bash

git submodule update --init --recursive

#Parameters
# $1 file to install
# $2 path & file to install to
function link {
	# Check if it exists
	if [ -f $2 ]
	then
		# Only back up non-symlinks
		if ! [ -L $2 ]
		then
			BACKUP_DIR="$(basename $2)-$(date +%Y%m%d)"
			echo "Backing up $2 to $PWD/.backup/$BACKUP_DIR"
			mkdir -p $PWD/.backup
			mv "$2" "$PWD/.backup/$BACKUP_DIR"
		fi
	fi
	echo "Linking $1 to $2"
	ln -s -f $PWD/$1 $2
}

# git
link gitconfig ~/.gitconfig

# vim
link vim ~/.vim
link vim/vimrc ~/.vimrc

# zsh
mkdir -p ~/.zsh
link zshrc ~/.zshrc
link antigen/antigen.zsh ~/.zsh/antigen.zsh

# xmodmap
link xmodmap ~/.xmodmap

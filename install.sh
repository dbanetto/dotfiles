#!/bin/bash

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
			echo "Backing up $2 to $PWD/backup/$BACKUP_DIR"
			mkdir -p $PWD/backup
			mv "$2" "$PWD/backup/$BACKUP_DIR"
		fi
	fi
	echo "Linking $1 to $2"
	ln -s -f $PWD/$1 $2
}

function copy {
	# Check if it exists
	if [ -f $2 ]
	then
		# Only back up non-symlinks
		if ! [ -L $2 ]
		then
			BACKUP_DIR="$(basename $2)-$(date +%Y%m%d)"
			echo "Backing up $2 to $PWD/backup/$BACKUP_DIR"
			mkdir -p $PWD/backup
			mv "$2" "$PWD/backup/$BACKUP_DIR"
		fi
	fi
	echo "Copying $1 to $2"
	cp -f $PWD/$1 $2
}

# git
link gitconfig ~/.gitconfig

# vim
git clone https://github.com/zyphrus/vim ~/.vim
link ~/.vim/vimrc ~/.vimrc

# zsh
link zshrc ~/.zshrc

# zgen
git clone https://github.com/tarjoilija/zgen ~/.zgen

# xmodmap
link xmodmap ~/.xmodmap

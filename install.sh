#!/bin/bash

# Parameters
# $1 What to backup
function backup {
# Check if it exists
if [ -f $1 ]
then
    # Only back up non-symlinks
    if ! [ -L $1 ]
    then
        BACKUP_DIR="$(basename $1)-$(date +%Y%m%d)"
        echo "Backing up $1 to $PWD/backup/$BACKUP_DIR"
        mkdir -p $PWD/backup
        mv "$1" "$PWD/backup/$BACKUP_DIR"
    fi
fi
}

#Parameters
# $1 file to install
# $2 path & file to install to
function link {
backup $2
echo "Linking $1 to $2"
ln -s -f $PWD/$1 $2
}

function copy {
backup $2
echo "Copying $1 to $2"
cp -f $PWD/$1 $2
}

# Xresouce
link Xresources ~/.Xresources

# vim
# git clone https://github.com/zyphrus/vim ~/.vim

# nvim
git clone https://github.com/zyphrus/nvim ~/.config/nvim

# zsh
link zshrc ~/.zshrc
# zgen
git clone https://github.com/tarjoilija/zgen ~/.zgen

# xmodmap
link xmodmap ~/.xmodmap

# git
link gitconfig ~/.gitconfig

# mpv
mkdir -p ~/.config/mpv
link mpv.conf ~/.config/mpv/mpv.conf

# tmux
mkdir -p ~/.local/bin
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
wget https://gist.githubusercontent.com/zyphrus/54878fa2b2509835cac7/raw/7169c1345d5f7e13d0dd1b7be0495d289abbe6bd/tmx -O ~/.local/bin/tmx
chmod +x ~/.local/bin/tmx
link tmux.conf ~/.tmux.conf
mkdir -p ~/.tmux
link osx.conf ~/.tmux/osx.conf

# rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv

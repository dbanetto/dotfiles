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

## (n)vim
git clone https://github.com/zyphrus/nvim ~/.config/nvim
ln -s -f  ~/.config/nvim/vimrc ~/.vimrc

## zsh
link zshrc ~/.zshrc
# zgen
git clone https://github.com/tarjoilija/zgen ~/.zgen

## git
link gitconfig ~/.gitconfig
# global ignore
link gitignore ~/.config/gitignore
git config --global core.excludesfile ~/.config/gitignore

## mpv
mkdir -p ~/.config/mpv
link mpv.conf ~/.config/mpv/mpv.conf

## alacritty
mkdir -p ~/.config/alacritty
link alacritty.yml ~/.config/alacritty/alacritty.yml

# OS specific
case "$(uname)" in
  Darwin)
    ;;
  Linux)
    # Xresources
    link Xresources ~/.Xresources
    link Xresources.d ~/.config/Xresouces.d
    ;;
esac

# vim: ft=sh:ts=2:sw=2:et

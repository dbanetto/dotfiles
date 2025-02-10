#!/usr/bin/env bash

set -euox pipefail

sudo apt update
sudo apt install -y neovim zsh gopls

curl -sS https://starship.rs/install.sh | sh

make all

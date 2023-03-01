#!/bin/bash

# Fish
sudo apt-add-repository ppa:fish-shell/release-3 -y
sudo apt update
sudo apt install fish -y
sudo apt install fonts-powerline -y
sudo chsh -s /usr/bin/fish $USER
fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fish -c "fisher install oh-my-fish/bobthefish"

# NVM
fish -c "fisher install jorgebucaran/nvm.fish"
fish -c "set --universal nvm_default_version v18"

# NeoVim
sudo apt install neovim -y
fish -c "alias vim='nvim' && funcsave vim"

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

mkdir -p $HOME/nvim
sudo apt install -y wget
wget https://raw.githubusercontent.com/julianpoy/dotfiles/master/.vimrc -O $HOME/nvim/init.vim

fish -c "sudo npm install -g yarn"
fish -c "sudo npm install -g neovim"

sudo apt install python3 -y
pip3 install pynvim

sudo apt install ripgrep -y
sudo apt install fd-find -y

# Tmux
sudo apt install tmux -y


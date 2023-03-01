#!/bin/bash

# Wget for various fetching
sudo apt install -y wget

# Fish
sudo apt-add-repository ppa:fish-shell/release-3 -y
sudo apt update
sudo apt install fish -y
sudo apt install fonts-powerline -y
sudo chsh -s /usr/bin/fish $USER
fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fish -c "fisher install oh-my-fish/theme-bobthefish"

# NVM
fish -c "fisher install jorgebucaran/nvm.fish"
fish -c "nvm install 18"
fish -c "set --universal nvm_default_version 18"
fish -c "set --universal nvm_default_packages yarn neovim"

# NeoVim
wget https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb -O /tmp/nvim.deb
sudo apt install /tmp/nvim.deb -y
fish -c "alias vim='nvim' && funcsave vim"

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

mkdir -p $HOME/.config/nvim
wget https://raw.githubusercontent.com/julianpoy/dotfiles/master/.vimrc -O $HOME/.config/nvim/init.vim

sudo apt install python3 -y
pip3 install pynvim

sudo apt install ripgrep -y
sudo apt install fd-find -y

nvim --headless +PlugInstall +qall

# Tmux
sudo apt install tmux -y
wget https://raw.githubusercontent.com/julianpoy/dotfiles/master/.tmux.conf -O $HOME/.tmux.conf


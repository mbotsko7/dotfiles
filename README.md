# My Dotfiles

Herein lies my configurations for various things.

I suggest cloning this repo and then symlinking files to the appropriate location so that pulls to this repo will update the associated spot.

## Vim Setup

For vim, you'll need a bunch of setup since my vimrc is highly customized with all sorts of "extras".

First, you'll need to install neovim. For MacOS that's as simple as `brew install neovim`. You'll also need to run the script `installNeoVim.sh`.

I suggest rebinding `vim` to `nvim` so that you can just start neovim via normal `vim`. With fish you can do that via:

```
alias vim='nvim'
funcsave vim
```

If you haven't already, you'll need to symlink the .vimrc in this repo to ~/.vimrc

For completion support, you'll need to install several neovim helpers:

```
npm install -g neovim
pip3 install pynvim
```

You'll also need to install ripgrep for search. For MacOS that's `brew install ripgrep`. For Debian-based, `sudo apt install ripgrep`.

If you want pretty icons, you'll need to install one of the fonts at https://www.nerdfonts.com/
To enable the icons change the pretty_icons setting at the top of the .vimrc

Now launch neovim and run `:PlugInstall`.


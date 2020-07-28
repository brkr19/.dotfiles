#!/bin/bash

(cd ~/.dotfiles && git submodule update --init --recursive && git submodule foreach --recursive git fetch)

ln -s ~/.dotfiles/.zshrc ~/.zshrc
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/tmux-plugins/oh-my-tmux/.tmux.conf ~/.tmux.conf
ln -s ~/.dotfiles/.tmux.conf.local ~/.tmux.conf.local
ln -s ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s ~/.dotfiles/ssh/config ~/.ssh/config

sudo chsh -s $(which zsh) $(whoami)
chsh -s $(which zsh)

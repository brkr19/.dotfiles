#!/bin/bash

ln -s -f ~/.dotfiles/.zshrc ~/.zshrc
ln -s -f ~/.dotfiles/.vimrc ~/.vimrc
ln -s -f ~/.dotfiles/tmux-plugins/oh-my-tmux/.tmux.conf ~/.tmux.conf
ln -s -f ~/.dotfiles/.tmux.conf.local ~/.tmux.conf.local
ln -s -f ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s -f ~/.dotfiles/ssh/config ~/.ssh/config

(cd ~/.dotfiles && git submodule update --init --recursive && git submodule foreach --recursive git fetch)


#!/bin/bash

ln -s -f ~/.dotfiles/.zshrc ~/.zshrc
ln -s -f ~/.dotfiles/.vimrc ~/.vimrc
ln -s -f ~/.dotfiles/tmux-plugins/oh-my-tmux/.tmux.conf ~/.tmux.conf
ln -s -f ~/.dotfiles/.tmux.conf.local ~/.tmux.conf.local
ln -s -f ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s -f ~/.dotfiles/ssh/config ~/.ssh/config

# Create .gitconfig.local if it doesn't exist
if [ ! -f ~/.gitconfig.local ]; then
    echo "Creating ~/.gitconfig.local from example..."
    cp ~/.dotfiles/.gitconfig.local.example ~/.gitconfig.local
    echo "Please edit ~/.gitconfig.local to add your user information."
fi

(cd ~/.dotfiles && git submodule update --init --recursive && git submodule foreach --recursive git fetch)

echo "Make sure to install ZSH and run 'chsh -s /usr/bin/zsh' if you haven't already done so."

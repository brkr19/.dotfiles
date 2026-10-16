#!/bin/bash

# Symlink $1 to $2, moving an existing file (not a symlink) at $2 to $2.bak
link() {
    if [ -e "$2" ] && [ ! -L "$2" ]; then
        echo "Backing up $2 to $2.bak"
        mv "$2" "$2.bak"
    fi
    ln -s -f "$1" "$2"
}

mkdir -p -m 700 ~/.ssh

link ~/.dotfiles/.zshrc ~/.zshrc
link ~/.dotfiles/.vimrc ~/.vimrc
link ~/.dotfiles/tmux-plugins/oh-my-tmux/.tmux.conf ~/.tmux.conf
link ~/.dotfiles/.tmux.conf.local ~/.tmux.conf.local
link ~/.dotfiles/.gitconfig ~/.gitconfig
link ~/.dotfiles/ssh/config ~/.ssh/config

# Create .gitconfig.local if it doesn't exist
if [ ! -f ~/.gitconfig.local ]; then
    echo "Creating ~/.gitconfig.local from example..."
    cp ~/.dotfiles/.gitconfig.local.example ~/.gitconfig.local
    echo "Please edit ~/.gitconfig.local to add your user information."
fi

(cd ~/.dotfiles && git submodule update --init --recursive)

ZSH_PATH=$(command -v zsh)
if [ -n "$ZSH_PATH" ]; then
    echo "Make sure to run 'chsh -s $ZSH_PATH' if zsh isn't already your shell."
else
    echo "Make sure to install zsh and set it as your shell with chsh."
fi

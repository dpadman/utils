#!/bin/bash

# Basic required packages
sudo apt-get update
sudo apt-get install -y cscope ctags
sudo apt-get install -y build-essential
sudo apt-get install -y cmake

mkdir -p ~/.vim/plugin
cp cscope_maps.vim ~/.vim/plugin/

cp gitconfig ~/.gitconfig
cp git_aliases ~/.git_aliases
cp svn_aliases ~/.svn_aliases
cp bash_aliases ~/.bash_aliases
cp bash_exports ~/.bash_exports
cp cs.script ~/.cs.script
cp vimrc ~/.vimrc
cp screenrc ~/.screenrc
cp bashrc ~/.bashrc

#!/bin/sh

# Work in progress. Installer script for dotfiles.

WD=$(pwd)

function link-folder () {
  local full_target_path="$WD/$1"
  local full_link_path="$HOME/.config/$1/"

  if [ -d $full_target_path ]; then
    ln -s $full_target_path $full_link_path
  else
    echo "Error: missing folder: $full_target_path"
    return -1
  fi
}

## zsh
link-folder("zsh")

# Redirect ZSH to use new config file location
ln -s $WD/zsh/.zshenv $HOME/.zshenv

## terminal
# Apply key mappings
ln -s $WD/inputrc $HOME/.inputrc
# Apply colorscheme
ln -s $WD/Xresources $HOME/.Xresources

## neovim
link-folder("nvim")

## tmux
link-folder("tmux")

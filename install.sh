#!/bin/bash

# Work in progress. Installer script for dotfiles.

WD=$(pwd)

link-folder () {
  local full_target_path="$WD/$1"
  local full_link_path="$XDG_CONFIG_HOME/$1"

  if [ -d $full_target_path ]; then
    ln -s $full_target_path $full_link_path
  else
    echo "Error: missing folder: $full_target_path"
    return -1
  fi
}

## zsh
link-folder "zsh"
# Redirect ZSH to use new config file location
ln -s $WD/zsh/.zshenv $HOME
# Install plugins
if ! [ -d $XDG_CONFIG_HOME/zsh/custom/plugins ]; then
  mkdir "$XDG_CONFIG_HOME/zsh/custom/plugins"
fi
git clone https://github.com/romkatv/powerlevel10k.git "$XDG_CONFIG_HOME/zsh/custom/plugins/powerlevel10k"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$XDG_CONFIG_HOME/zsh/custom/plugins/fast-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$XDG_CONFIG_HOME/zsh/custom/plugins/zsh-autosuggestions"

## neovim
link-folder "nvim"

## tmux
link-folder "tmux"

## terminal convenience
# Apply key mappings
ln -s $WD/inputrc $HOME/.inputrc
# Apply colorscheme
ln -s $WD/Xresources $HOME/.Xresources


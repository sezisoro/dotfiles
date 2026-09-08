#!/bin/bash
# Work in progress. Installer script for dotfiles.
# Author:	sez

if [[ -z $XDG_CONFIG_HOME ]]; then
	XDG_CONFIG_HOME="$HOME/.config"
fi

WD=$(pwd)

link-folder () {
	local full_target_path="$WD/$1"
	local full_link_path="$XDG_CONFIG_HOME/$1"
	if [ -d $full_target_path ]; then
		if [ -h $full_link_path ]; then
			echo "Error: link already exists: $full_link_path"
			return -1
		else
			ln -s "$full_target_path" "$full_link_path"
		fi
	else
		echo "Error: missing folder: $full_target_path"
		return -1
	fi
}

# Install packages
if [[ -z $(which tmux) || -z $(which zsh) || -z $(which nvim) ]]; then
	if [[ -n $(which apt) ]]; then
		apt install tmux zsh neovim
	elif [[ -n $(which pacman) ]]; then
		pacman -S tmuz zsh neovim
	fi
fi

mkdir -p "$HOME/.config"

## zsh
link-folder "zsh"

# Redirect ZSH to use new config file location
ln -s $WD/zsh/.zshenv $HOME/.zshenv

# Install plugins
if ! [ -d $XDG_CONFIG_HOME/zsh/custom/plugins ]; then
	mkdir -p "$XDG_CONFIG_HOME/zsh/custom/plugins"
fi
git clone https://github.com/romkatv/powerlevel10k.git "$XDG_CONFIG_HOME/zsh/custom/plugins/powerlevel10k"
git clone https://github.com/zdharma-continuum/fast-syntax-highlighting.git "$XDG_CONFIG_HOME/zsh/custom/plugins/fast-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions.git "$XDG_CONFIG_HOME/zsh/custom/plugins/zsh-autosuggestions"

## terminal
# Apply key mappings
ln -s $WD/inputrc $HOME/.inputrc
# Apply colorscheme
ln -s $WD/Xresources $HOME/.Xresources

## neovim
link-folder "nvim"

## tmux
link-folder "tmux"

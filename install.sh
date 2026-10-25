#!/bin/bash
# Work in progress. Installer script for dotfiles.
# Author:	sez

TARGETS=('fish', 'nvim', 'zellij')

if [[ -z $XDG_CONFIG_HOME ]]; then
	XDG_CONFIG_HOME="$HOME/.config"
fi

if [[ ! -d "$XDG_CONFIG_HOME" ]]; then
	mkdir -p "$XDG_CONFIG_HOME"
fi

link-folder() {
	local full_target_path=$(realpath "$1")
	local full_link_path=$(realpath "$XDG_CONFIG_HOME/$1")
	if [[ -L $full_link_path || -d $full_link_path ]]; then
		echo "Error: link already exists: $full_link_path"
		return -1
	fi

	if [[ -d $full_target_path ]]; then
		ln -s "$full_target_path" "$full_link_path"
	else
		echo "Error: missing folder: $full_target_path"
		return -1
	fi
}

# Apply key mappings
ln -s $(realpath inputrc) $HOME/.inputrc

for target in ${TARGETS[@]}; do
	link-folder "${target}"
done

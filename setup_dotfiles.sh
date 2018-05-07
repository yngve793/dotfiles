#!/bin/bash

dotfiles=(".gitignore_global" ".gitconfig")
dir="${HOME}/dotfiles"

echo "Set dir to ${dir}"

for dotfile in "${dotfiles[@]}";do
		echo "Creating symlink for ${dotfile}"
#  echo  "${HOME}/${dotfile}"
#  echo "${dir}/${dotfile}"
		ln -sf "${dir}/${dotfile}" "${HOME}/${dotfile}"
done

dotconfdirs=("i3")
for dotconfdir in "${dotconfdirs[@]}";do
		echo "Creating symlink for .config/${dotconfdir}"
		rm -rf "${HOME}/.config/${dotconfdir}"
		ln -sf "${dir}/${dotconfdir}" "${HOME}/.config/${dotconfdir}"		
done

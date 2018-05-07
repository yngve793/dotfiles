#!/bin/bash

dotfiles=(".gitignore_global" ".gitconfig" ".emacs")
dir="${HOME}/dotfiles"

echo "Set dir to ${dir}"

for dotfile in "${dotfiles[@]}";do
		echo "Creating symlink for ${dotfile}"
#  echo  "${HOME}/${dotfile}"
#  echo "${dir}/${dotfile}"
		ln -sf "${dir}/${dotfile}" "${HOME}/${dotfile}"
done

dotconfdirs=("i3")

appendname=""
if [ "$HOSTNAME" = "CRD-L-05716" ]; then
    appendname="_linuxSubSystem"
else
    appendname=""
fi

echo "Set appendname to ${appendname}"

for dotconfdir in "${dotconfdirs[@]}";do
		echo "Creating symlink for .config/${dotconfdir}"
		rm -rf "${HOME}/.config/${dotconfdir}"
		ln -sf "${dir}/${dotconfdir}${appendname}" "${HOME}/.config/${dotconfdir}"		
done

#!/usr/bin/bash

dotfiles=(".gitignore_global" ".gitconfig")
dir="${HOME}/dotfiles"

echo "Set dir to ${dir}"

for dotfile in "${dotfiles[@]}";do
  echo "Creating symlink for ${dotfile}"
#  echo  "${HOME}/${dotfile}"
#  echo "${dir}/${dotfile}"
  ln -sf "${dir}/${dotfile}" "${HOME}/${dotfile}"
done

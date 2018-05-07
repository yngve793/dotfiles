#!/bin/bash

dotfiles=(".gitignore_global" ".gitconfig" ".emacs" ".bashrc")
dir="${HOME}/dotfiles"

echo "Set dir to ${dir}"

for dotfile in "${dotfiles[@]}";do
		echo "Creating symlink for ${dotfile}"
#  echo  "${HOME}/${dotfile}"
#  echo "${dir}/${dotfile}"
		ln -sf "${dir}/${dotfile}" "${HOME}/${dotfile}"
done

deploy_configs () {
  echo "Deploy directories in .config"
  appendname=$1
  dotconfdir=$2
  for dotconfdir in "${dotconfdirs[@]}";do
		echo "Creating symlink for .config/${dotconfdir}"
		rm -rf "${HOME}/.config/${dotconfdir}"
		ln -sf "${dir}/${appendname}${dotconfdir}" "${HOME}/.config/${dotconfdir}"		
  done
}


# System independent 
dotconfdirs=("dunst")

deploy_configs "" "${dotconfdirs}"

dotconfdirs=("i3")

appendname=""

case $HOSTNAME in
  (CRD-L-05716) appendname="linuxSubsystem/";;
  (*) appendname="";;
esac
echo "Set appendname to ${appendname}"

deploy_configs "${appendname}" "${dotconfdirs}"

#for dotconfdir in "${dotconfdirs[@]}";do
#		echo "Creating symlink for .config/${dotconfdir}"
#		rm -rf "${HOME}/.config/${dotconfdir}"
#		ln -sf "${dir}/${appendname}${dotconfdir}" "${HOME}/.config/${dotconfdir}"		
#done

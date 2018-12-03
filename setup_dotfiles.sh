#!/bin/bash

dotfiles=(".gitignore_global" ".gitconfig" ".emacs" ".bashrc" ".vimrc" ".tmux.conf")
dir="${HOME}/dotfiles"

# Check if there is an update in my repository
if git pull ; then
	#Deployed my normal dotfiles
	echo "Looking for updates in my repository"
else
	exit $?
fi

echo "Set dir to ${dir}"

for dotfile in "${dotfiles[@]}";do
		echo "Creating symlink for ${dotfile}"
#  echo  "${HOME}/${dotfile}"
#  echo "${dir}/${dotfile}"
		ln -sf "${dir}/${dotfile}" "${HOME}/${dotfile}"

		case ${dotfile} in
		  (.vimrc)	rm -rf "${HOME}/.vim"
				ln -sf "${dir}/vim" "${HOME}/.vim";;
		  (*) ;;
		esac
done

deploy_configs () {
  echo "Deploy directories in .config"
  appendname=$1
  dotconfdirs=$2
  for dotconfdir in "${dotconfdirs[@]}";do
		echo "Creating symlink for .config/${dotconfdir}"
		rm -rf "${HOME}/.config/${dotconfdir}"
		ln -sf "${dir}/${appendname}${dotconfdir}" "${HOME}/.config/${dotconfdir}"		
  done
}

# Deployment of configurations residing in .config/

# System-independent 
dotconfdirsSystemIndependent=("dunst")
# Deploy
deploy_configs "" "${dotconfdirsSystemIndependent}"

# System-dependent
dotconfdirsSystemDependent=("i3")

appendname=""

case $HOSTNAME in
  (CRD-L-05716) appendname="linuxSubsystem/";;
  (*) appendname="";;
esac
echo "Set appendname to ${appendname}"

deploy_configs "${appendname}" "${dotconfdirsSystemDependent}"



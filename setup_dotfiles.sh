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


deploy_config_files () {
  echo "Deploy directories in .config"
  d=$1
  configfiles=$2
  for configfile in "${configfiles[@]}";do
		echo "Creating symlink for .config/${configfile}"
		rm -f "${HOME}/.config/${configfile}"
		ln -sf "${dir}/${d}${configfile}" "${HOME}/.config/${configfile}"		
  done
}


deploy_configs_dirs () {
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

general_config_files=("")
deploy_config_files "${config_files}"

# System-independent 
dotconfdirsSystemIndependent=("dunst")
# Deploy
deploy_configs_dirs "" "${dotconfdirsSystemIndependent}"

# System-dependent
dotconfdirsSystemDependent=("i3")

appendname=""

case $HOSTNAME in
  (CRD-L-05716) appendname="linuxSubsystem/";;
  (lapsgs24) appendname="lapsgs24/";;
  (*) appendname="";;
esac
echo "Set appendname to ${appendname}"

deploy_configs_dirs "${appendname}" "${dotconfdirsSystemDependent}"

platform_config_files=("rdiff-exclude")
deploy_config_files "${appendname}" "${platform_config_files}"


#!/usr/bin/env bash

dotfiles=("gitignore_global" "gitconfig" "emacs" "bashrc" "vimrc" "tmux.conf" "bash_aliases" "bash_functions" "bash_exports" "bash_profile")
dir="${HOME}/dotfiles"

# Check if there is an update in my repository
#if git pull ; then
#	#Deployed my normal dotfiles
#	echo "Looking for updates in my repository"
#else
#	#exit $?
#  echo "Could not update dotfiles"
#fi

echo "Set dir to ${dir}"

for dotfile in "${dotfiles[@]}";do

    if [[ -f "${dir}/${dotfile}" ]]; then
		  echo "Creating symlink for ${dotfile}"
		  ln -sf "${dir}/${dotfile}" "${HOME}/.${dotfile}"

		  case ${dotfile} in
		    (.vimrc)	rm -rf "${HOME}/.vim"
				  ln -sf "${dir}/vim" "${HOME}/.vim";;
		    (*) ;;
		  esac
		fi
done


deploy_config_files () {
  echo "Deploy config files in .config/"
  d=$1
  shift
  echo "$@"
  configfiles=("$@")

  echo "List of config files to deploy ${configfiles[@]}"
  echo "${configfiles}"
  for configfile in "${configfiles[@]}";do
  		echo "Creating symlink for .config/${configfile}"
			if [[ -f "${dir}/${d}${configfile}" ]]; then
    		rm -f "${HOME}/.config/${configfile}"
  		fi
  		ln -sf "${dir}/${d}${configfile}" "${HOME}/.config/${configfile}"
  done
}


deploy_configs_dirs () {
  echo "Deploy directories in .config/"
  appendname=$1
  shift
  dotconfdirs=("$@")
  echo "List of config dirs to deploy ${dotconfdirs[@]}"
  for dotconfdir in "${dotconfdirs[@]}";do
    if [[ -d "${dir}/${appendname}${dotconfdir}" ]]; then
		  echo "Creating symlink for .config/${dotconfdir}"
		  rm -rf "${HOME}/.config/${dotconfdir}"
		  ln -sf "${dir}/${appendname}${dotconfdir}" "${HOME}/.config/${dotconfdir}"
    else
      echo "Skipping config dir for .config/${dotconfdir} as it already exists."
		fi
  done
}

# Deployment of configurations residing in .config/
general_config_files=("")
deploy_config_files "${config_files}"

# System-independent
dotconfdirsSystemIndependent=("dunst" "swaywm")
# Deploy
deploy_configs_dirs "" "${dotconfdirsSystemIndependent[@]}"

# System-dependent
dotconfdirsSystemDependent=("i3")

appendname=""

case $HOSTNAME in
  lapsgs24 | archpc ) appendname="$HOSTNAME/";;
  *) appendname="";;
esac
echo "Set appendname to ${appendname}"

deploy_configs_dirs "${appendname}" "${dotconfdirsSystemDependent[@]}"

platform_config_files=()
case $HOSTNAME in
  (lapsgs24) platform_config_files=("rdiff-exclude" "rdiff-include");;
esac
deploy_config_files "${appendname}" ${platform_config_files[@]}


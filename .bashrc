#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Source standard profile
if [[ -f /etc/profile ]]; then
	. /etc/profile
fi

#if [ -d /etc/profile.d ]; then
#  for i in /etc/profile.d/*.sh; do
#    if [ -r $i ]; then
#      . $i
#    fi
#  done
#fi


# Source standard bashrc
if [[ -f /etc/bash.bashrc ]]; then
	source /etc/bash.bashrc
fi
if [[ -f /usr/local.nfs/rc/bashrc ]]; then
#  echo "Sourcing special bashrc"
  source /usr/local.nfs/rc/bashrc
fi

# needed for arch
if [[ -d /usr/share/git/completion/ ]]; then
  source /usr/share/git/completion/git-completion.bash
  source /usr/share/git/completion/git-prompt.sh
fi

# fzf
if [[ -d /usr/share/fzf/ ]]; then
  source /usr/share/fzf/completion.bash
  source /usr/share/fzf/key-bindings.bash
fi

export PATH=${HOME}/.local/bin:${PATH}
export PATH=${HOME}/bin:${PATH}
if [[ -d ${HOME}/bin/git-annex.linux ]]; then
  export PATH="${HOME}/bin/git-annex.linux":${PATH}
fi
export PATH=${PATH}:~/bin/"${HOSTNAME}"

case $HOSTNAME in
  (CRD-L-05716) source /etc/bash.bashrc;;
  (lapsgs24) 
#    source /etc/profile.d/lmod.sh
    export MODULEPATH=/usr/share/lmod/6.6/modulefiles/Core
    export MODULEPATH=${HOME}/modulefiles:${MODULEPATH}
    ;;
  (neon)
    export MODULEPATH=${MODULEPATH}:/data/scratch/jaustar/modulefiles
    #module purge
    #module load preCICE/1.6.0-opt
    #module load cmake/3.12.1
    ;;
  (*) 
	;;
esac

case $HOSTNAME in
  (lapsgs24) 
    export PS1="\[\033[0;32m\]\u\[\033[0;36m\]@\h:\w\[\033[0;32m\]\$(__git_ps1)\n└─(\[\033[1;32m\]\t, \$(ls -1 | wc -l | sed 's: ::g') files, \$(ls -sh | head -n1 | sed 's/total //')b\[\033[1;37m\]\[\033[0;32m\])\342\224\200>\[\033[0m\] "
    ;;
  (neon | helium | sgscl* | kepler | vgpu | argon* )
    export PS1="\[\033[0;32m\]\u\[\033[0;36m\]@\h:\w\[\033[0;32m\]\$(__git_ps1)\n└─(\[\033[1;32m\]\t, \$(ls -1 | wc -l | sed 's: ::g') files, \$(ls -sh | head -n1 | sed 's/total //')b\[\033[1;37m\]\[\033[0;32m\])\342\224\200>\[\033[0m\] "
    ;;
  (*)
    export PS1="\u\[\033[1;34m\]@\h\[\033[0m\]:\[\033[0;32m\]\w\[\033[0;32m\]\$(__git_ps1)\n└─(\[\033[1;32m\]\t, \$(ls -1 | wc -l | sed 's: ::g') files, \$(ls -sh | head -n1 | sed 's/total //')b\[\033[1;37m\]\[\033[0;32m\])\342\224\200>\[\033[0m\] "
    ;;
esac 



# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Keep 1000 lines in .bash_history (default is 500)
export HISTSIZE=1000
export HISTFILESIZE=1000

# Use gnome-keyring on a desktop session or else run ssh-agent
#This also takes care that only one ssh-agent is running. I don't know if this conflicts with gnome.
#https://wiki.archlinux.org/index.php/SSH_keys#ssh-agent
if [[ ! -z "${DESKTOP_SESSION}" ]];then
    #eval $(gnome-keyring-daemon --start)
#    echo "Starting gnome keyring as we are running a desktop session"
#    echo "Value of DESKTOP_SESSION ${DESKTOP_SESSION}"
#    eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
#    export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
#    dbus-update-activation-environment --systemd DISPLAY
    eval $(gnome-keyring-daemon --start)
    export SSH_AUTH_SOCK
    #export SSH_AUTH_SOCK
#  echo "Don't do anything about the ssh keys"
#if [[ ! -z "${DESKTOP_SESSION}" ]];then
#    echo "Starting gnome keyring as we are running a desktop session"
#    export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
#else
#if [ -n "$DESKTOP_SESSION" ];then
#    eval $(gnome-keyring-daemon --start)
#    export SSH_AUTH_SOCK
else
#Start ssh-agent
	if ! pgrep -u "$USER" ssh-agent > /dev/null; then
		  ssh-agent > ~/.ssh-agent-thing
	fi
	if [[ "$SSH_AGENT_PID" == "" ]]; then
		  eval "$(<~/.ssh-agent-thing)"
	fi
fi

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

alias ls='ls --color=auto'
#PS1='[\u@\h \W]\$ '
#PS1='\[\e[1;35m\]\u\[\e[m\] \[\e[1;36m\]\w\[\e[m\] \[\e[1;32m\]> \[\e[m\]\[\e[0;37m\]'
#PS2='>'
#if [[ ${EUID} == 0 ]] ; then
#		sq_color="\[\033[0;31m\]"
#else		
#	sq_color="\[\033[0;34m\]"
#PS1="$sq_color\342\224\214\342\224\200\$([[ \$? != 0 ]] && echo \"[\[\033[01;37m\]\342\234\227$sq_color]\342\224\200\")[\[\033[01;37m\]\t$sq_color]\342\224\200[\[\033[01;37m\]\u@\h$sq_color]\n\342\224\224\342\224\200\342\224\200> \[\033[01;37m\]\W$sq_color $ \[\033[01;37m\]>>\\[\\033[0m\\] "
#unset sq_color

# http://maketecheasier.com/8-useful-and-interesting-bash-prompts/2009/09/04
#PS1="\n\[\033[1;37m\]\342\224\214($(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;34m\]\u@\h'; fi)\[\033[1;37m\])\342\224\200(\$(if [[ \$? == 0 ]]; then echo \"\[\033[01;32m\]\342\234\223\"; else echo \"\[\033[01;31m\]\342\234\227\"; fi)\[\033[1;37m\])\342\224\200(\[\033[1;34m\]\@ \d\[\033[1;37m\])\[\033[1;37m\]\n\342\224\224\342\224\200(\[\033[1;32m\]\w\[\033[1;37m\])\342\224\200(\[\033[1;32m\]\$(ls -1 | wc -l | sed 's: ::g') files, \$(ls -sh | head -n1 | sed 's/total //')b\[\033[1;37m\])\342\224\200> \[\033[0m\]"

#PS1="(\[\033[1;32m\]\$(ls -1 | wc -l | sed 's: ::g') files, \$(ls -sh | head -n1 | sed 's/total //')b\[\033[1;37m\]) \[\033[0m\]"

# http://maketecheasier.com/8-useful-and-interesting-bash-prompts/2009/09/04
#PS1="\n\[\033[1;37m\]\342\224\214($(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;34m\]\u@\h'; fi)\[\033[1;37m\])\$([[ \$? != 0 ]] && echo \"\342\224\200(\[\033[0;31m\]\342\234\227\[\033[1;37m\])\")\342\224\200(\[\033[1;34m\]\@ \d\[\033[1;37m\])\[\033[1;37m\]\n\342\224\224\342\224\200(\[\033[1;32m\]\w\[\033[1;37m\])\342\224\200(\[\033[1;32m\]\$(ls -1 | wc -l | sed 's: ::g') files, \$(ls -sh | head -n1 | sed 's/total //')b\[\033[1;37m\])\342\224\200> \[\033[0m\]"

export OMP_NUM_THREADS=1

export EDITOR=vim



# JAVA
# Make Java use anti-aliasing for nicer fonts
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"

# Enable X-forwarding on windows subsystem
case $HOSTNAME in
  (CRD-L-05716) export DISPLAY=127.0.0.1:0
#    export TERM=rxvt-unicode-256color
  ;;
  (*) ;;
esac


case $HOSTNAME in
  (lapsgs24)

    module load Eigen/3-Ubuntu
    module load PETSc/3.7.7-Ubuntu
    module load preCICE/1.6.0-Release-MPI-PETSc-Python

    module load CoDiPack/1.7
    module load Togl/1.7
    module load NGSolve/5.0.0-opt
    #module load spack

    module load pdfsam

    # Go and singularity
    export GOPATH=${HOME}/go
    export PATH=$PATH:/usr/local/go/bin:${GOPATH}/bin
    export PATH=/usr/local/singularity/bin/:${PATH}
    . /usr/local/etc/bash_completion.d/singularity

    # Calculix adapter
    #export PATH=/home/jaustar/software/calculix-adapter-master/bin/:${PATH}
    # yaml for calculix adapter
    #export LD_LIBRARY_PATH=/home/jaustar/software/yaml-cpp-yaml-cpp-0.6.2/build:${LD_LIBRARY_PATH}
    #export CPLUS_INCLUDE_PATH=/home/jaustar/software/yaml-cpp-yaml-cpp-0.6.2/include:${CPLUS_INCLUDE_PATH}

    # OpenFOAM
    #. /opt/openfoam5/etc/bashrc
    # JabRef
  ;;
  (sgscl*)
#    if [ -z ${SPACK_ROOT+x}]; then
      echo "Loading Spack environment"
      SPACK_ROOT="${HOME}/software/sgscl/spack/"
      . ${SPACK_ROOT}/share/spack/setup-env.sh
#    fi
    #SPACK_ROOT=/scratch-nfs/jaustar/software/spack/
    #. ${SPACK_ROOT}/share/spack/setup-env.sh

    export MODULEPATH=/scratch-nfs/jaustar/modulefiles:${MODULEPATH}

#    echo "Loading conda paths"
#    # >>> conda initialize >>>
#    # !! Contents within this block are managed by 'conda init' !!
#  __conda_setup="$('/scratch-nfs/jaustar/miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#    if [ $? -eq 0 ]; then
#      eval "$__conda_setup"
#    else
#      if [ -f "/scratch-nfs/jaustar/miniconda/etc/profile.d/conda.sh" ]; then
#          . "/scratch-nfs/jaustar/miniconda/etc/profile.d/conda.sh"
#      else
#          export PATH="/scratch-nfs/jaustar/miniconda/bin:$PATH"
#      fi
#    fi
#    unset __conda_setup
#    # <<< conda initialize <<<
  ;;
  (helium)
#    export PATH="/home/jaustar/.local/bin":${PATH}
   export SPACK_ROOT=/data/scratch/jaustar/software/spack 
   . $SPACK_ROOT/share/spack/setup-env.sh
   
   #module load gcc-9.2.0
#   module load cmake-3.16.2-gcc-9.2.0-ljlwrtm hdf5-1.10.6-gcc-9.2.0-bz7qlyl hypre-2.18.2-gcc-9.2.0-cnzymc5 libxml2-2.9.9-gcc-9.2.0-xkezdjp metis-5.1.0-gcc-9.2.0-c7abmhx openblas-0.3.7-gcc-9.2.0-5rpbwaz openmpi-3.1.5-gcc-9.2.0-4tcwjfk parmetis-4.0.3-gcc-9.2.0-qplagoc petsc-3.12.3-gcc-9.2.0-ymzqoeb pkg-config-0.29.2-gcc-9.2.0-trb2g2j py-cython-0.29.14-gcc-9.2.0-teashjw py-numpy-1.18.1-gcc-9.2.0-4dfpycp py-ply-3.11-gcc-9.2.0-yrzqe34 python-3.7.6-gcc-9.2.0-lium4ub superlu-dist-6.1.1-gcc-9.2.0-5brfmvi zlib-1.2.11-gcc-9.2.0-krudt66
   #module load boost-1.72.0-gcc-9.2.0-ndisizz precice-1.6.1-gcc-9.2.0-zdd5wkb

   #source /data/scratch/jaustar/software/fenics/dolfin-install/share/dolfin/dolfin.conf
     #> >>conda initialize >>>
    # !! Contents within this block are managed by 'conda init' !!
#  __conda_setup="$('/data/scratch/jaustar/software/miniconda/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
#    if [ $? -eq 0 ]; then
#      eval "$__conda_setup"
#    else
#      if [ -f "/data/scratch/jaustar/software/miniconda/etc/profile.d/conda.sh" ]; then
#          . "/data/scratch/jaustar/software/miniconda/etc/profile.d/conda.sh"
#      else
#          export PATH="/data/scratch/jaustar/software/miniconda/bin:$PATH"
#      fi
#    fi
#    unset __conda_setup
    # <<< conda initialize <<<
  ;;
  (neon)
    export SPACK_ROOT=/data/scratch/jaustar/software/spack 
    . $SPACK_ROOT/share/spack/setup-env.sh

#    module load gcc-9.2.0 boost-1.72.0-gcc-9.2.0-qt2uz5a cmake-3.16.2-gcc-9.2.0-p7bn2rm eigen-3.3.7-gcc-9.2.0-zz3jboq hdf5-1.10.6-gcc-9.2.0-dg3dgwq hypre-2.18.2-gcc-9.2.0-5tmxvkd libxml2-2.9.9-gcc-9.2.0-kxifw4y metis-5.1.0-gcc-9.2.0-iyx6a25 openblas-0.3.7-gcc-9.2.0-aw6aebh openmpi-3.1.5-gcc-9.2.0-q5igqm3 parmetis-4.0.3-gcc-9.2.0-nrateej petsc-3.12.3-gcc-9.2.0-s7c565z precice-1.6.1-gcc-9.2.0-sdgxbmq py-numpy-1.18.1-gcc-9.2.0-yutave2 py-ply-3.11-gcc-9.2.0-pjdqlj4 python-3.7.6-gcc-9.2.0-kek67k7 superlu-dist-6.1.1-gcc-9.2.0-2o7s2ly zlib-1.2.11-gcc-9.2.0-myrpqhu

    #source /data/scratch/jaustar/software/fenics/dolfin-install/share/dolfin/dolfin.conf
  ;;
  (argon-*)
    export SPACK_ROOT=/home/jaustar/software/spack 
    . $SPACK_ROOT/share/spack/setup-env.sh

    module load gcc-9.2.0
    case $HOSTNAME in
      (argon-epyc)
        echo "Importing dolfin"
        source /home/jaustar/software/epyc/fenics/dolfin/build/home/jaustar/software/epyc/fenics/dolfin-install/share/dolfin/dolfin.conf
        ;;
      (*)
        ;;
    esac
  ;;
  (*) 
    export CODIPACKDIR=/opt/CoDiPack
    #export DISTCC_HOSTS="deepthought/5,lzo,cpp archpc/9,lzo,cpp"
    export DISTCC_HOSTS="deepthought/5,lzo,cpp"
    case ${HOSTNAME} in
    (archpc)
      source /etc/profile.d/modules.sh
      #Spack
      export SPACK_ROOT=${HOME}/software/spack
      . $SPACK_ROOT/share/spack/setup-env.sh
      export MODULEPATH=/opt/modulefiles:${MODULEPATH}
      export PETSC_DIR=/opt/petsc-3.11.4-opt
      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PETSC_DIR/lib/:/opt/Togl-1.7/lib
      module load netgen/5.0.0-opt
#      export NETGENDIR=/opt/netgen-5.0.0-opt/bin
#      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PETSC_DIR/lib/:/opt/Togl-1.7/lib:"${NETGENDIR}/../lib"
#      export PATH=$PATH:"${NETGENDIR}"
      # added by Miniconda3 4.5.12 installer
      # >>> conda init >>>
      # !! Contents within this block are managed by 'conda init' !!
#      __conda_setup="$(CONDA_REPORT_ERRORS=false '/home/alex/software/miniconda3/bin/conda' shell.bash hook 2> /dev/null)"
#      if [ $? -eq 0 ]; then
#          \eval "$__conda_setup"
#      else
#          if [ -f "/home/alex/software/miniconda3/etc/profile.d/conda.sh" ]; then
#              . "/home/alex/software/miniconda3/etc/profile.d/conda.sh"
#              CONDA_CHANGEPS1=false conda activate base
#          else
#              \export PATH="/home/alex/software/miniconda3/bin:$PATH"
#          fi
#      fi
#      unset __conda_setup
      # <<< conda init <<<
      ;;
    (*)
      ;;
  esac
  ;;
esac

#if [ "$COLORTERM" == "xfce4-terminal" ] ; then
#    export TERM=xterm-256color
#fi




[ -f ~/.fzf.bash ] && source ~/.fzf.bash

extend_dune_control_path(){
#  echo "$#"
#  echo "OLD DUNE_CONTROL_PATH=${DUNE_CONTROL_PATH}"
  path_to_add=${PWD}
  if [ "$#" -ge 1 ]; then
    if [[ "${1}" == "--help" || "${1}" == "-h" ]]; then
      echo "extend_dune_control_path PATH_TO_ADD PATH_TO_ADD"
      echo ""
      echo "If PATH_TO_ADD is not specified the current working directory is added"
      return 0
    else
  #    IFS=":"
  #    path_to_add="${*}"
      path_to_add=""
      for path in "$@"
      do
        if [[ "${path}" == /* ]]; then
          if [[ "${path_to_add}" == "" || "${DUNE_CONTROL_PATH}" == :*  ]]; then
            path_to_add="${path}"
          else
            path_to_add="${path}:${path_to_add}"
          fi
        else
          path_to_add="${PWD}/${path}:${path_to_add}"
        fi
      done
      echo "${path_to_add}"
    fi
  fi
  export DUNE_CONTROL_PATH="${path_to_add}""${DUNE_CONTROL_PATH}"

#  if [ -z "${DUNE_CONTROL_PATH}" ]; then
#    export DUNE_CONTROL_PATH="${path_to_add}"
#  else
#    export DUNE_CONTROL_PATH="${path_to_add}":"${DUNE_CONTROL_PATH}"
#  fi
  echo "NEW DUNE_CONTROL_PATH=${DUNE_CONTROL_PATH}"
  return 0
}

show_dune_control_path(){
  echo "DUNE_CONTROL_PATH=${DUNE_CONTROL_PATH}"
  return 0
}

if [[ -f ~/.bash_aliases ]]; then
  source ~/.bash_aliases
fi

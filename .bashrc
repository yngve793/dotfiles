#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

if [ -d /etc/profile.d ]; then
  for i in /etc/profile.d/*.sh; do
    if [ -r $i ]; then
      . $i
    fi
  done
fi

if [[ -f ~/.bash_aliases ]]; then
  source ~/.bash_aliases
fi

# Source standard bashrc
if [[ -f /etc/bash.bashrc ]]; then
	source /etc/bash.bashrc
fi
if [[ -f /usr/local.nfs/rc/bashrc ]]; then
  source /usr/local.nfs/rc/bashrc
fi
case $HOSTNAME in
  (CRD-L-05716) source /etc/bash.bashrc;;
  (lapsgs24) 
#    source /etc/profile.d/lmod.sh
    export MODULEPATH=/usr/share/lmod/6.6/modulefiles/Core
    export MODULEPATH=${HOME}/modulefiles:${MODULEPATH}
    ;;
  (*) 
	;;
esac

case $HOSTNAME in
  (lapsgs24) 
    export PS1='\[\033[0;32m\]\u\[\033[0;36m\] @ \h \w\[\033[0;32m\]$(__git_ps1)\n└─ ▶\[\033[0m\] '
    ;;
  (neon | helium)
    export PS1='\[\033[0;32m\]\u\[\033[0;36m\] @ \h \w\[\033[0;32m\]$(__git_ps1)\n└─ ▶\[\033[0m\] '
    ;;
  (*)
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
if [ -n "$DESKTOP_SESSION" ];then
    #eval $(gnome-keyring-daemon --start)
    eval $(/usr/bin/gnome-keyring-daemon --start --components=gpg,pkcs11,secrets,ssh)
    export $(gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)
    dbus-update-activation-environment --systemd DISPLAY
    export SSH_AUTH_SOCK
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


#PS1='[\u@\h \W]\$ '


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
    module load preCICE/1.4-Release-MPI-PETSc-Python

    module load CoDiPack/1.7
    module load Togl/1.7
    module load NGSolve/5.0.0-opt

    module load pdfsam

    # Calculix adapter
    export PATH=/home/jaustar/software/calculix-adapter-master/bin/:${PATH}
    # yaml for calculix adapter
    export LD_LIBRARY_PATH=/home/jaustar/software/yaml-cpp-yaml-cpp-0.6.2/build:${LD_LIBRARY_PATH}
    export CPLUS_INCLUDE_PATH=/home/jaustar/software/yaml-cpp-yaml-cpp-0.6.2/include:${CPLUS_INCLUDE_PATH}

    # OpenFOAM
    . /opt/openfoam5/etc/bashrc
    # JabRef
  ;;

  (*) 
    export CODIPACKDIR=/opt/CoDiPack
    #export DISTCC_HOSTS="deepthought/5,lzo,cpp archpc/9,lzo,cpp"
    export DISTCC_HOSTS="deepthought/5,lzo,cpp"
    export CODIPACKDIR=/opt/CoDiPack
    case ${HOSTNAME} in
    (archpc)
      export PETSC_DIR=/opt/petsc-3.11.1-opt
      export NETGENDIR=/opt/netgen-5.0.0-opt/bin
      export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PETSC_DIR/lib/:/opt/Togl-1.7/lib
      export PATH=$PATH:$NETGENDIR
      # added by Miniconda3 4.5.12 installer
      # >>> conda init >>>
      # !! Contents within this block are managed by 'conda init' !!
      __conda_setup="$(CONDA_REPORT_ERRORS=false '/home/alex/software/miniconda3/bin/conda' shell.bash hook 2> /dev/null)"
      if [ $? -eq 0 ]; then
          \eval "$__conda_setup"
      else
          if [ -f "/home/alex/software/miniconda3/etc/profile.d/conda.sh" ]; then
              . "/home/alex/software/miniconda3/etc/profile.d/conda.sh"
              CONDA_CHANGEPS1=false conda activate base
          else
              \export PATH="/home/alex/software/miniconda3/bin:$PATH"
          fi
      fi
      unset __conda_setup
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


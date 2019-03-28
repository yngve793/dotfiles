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


# Source standard bashrc
case $HOSTNAME in
  (CRD-L-05716) source /etc/bash.bashrc;;
  (lapsgs24) 
    source /etc/bash.bashrc
#    source /etc/profile.d/lmod.sh
    export MODULEPATH=/usr/share/lmod/6.6/modulefiles/Core
    export MODULEPATH=${HOME}/modulefiles:${MODULEPATH}
    ;;
  (*) ;;
esac


# Use gnome-keyring on a desktop session or else run ssh-agent
#This also takes care that only one ssh-agent is running. I don't know if this conflicts with gnome.
#https://wiki.archlinux.org/index.php/SSH_keys#ssh-agent
if [ -n "$DESKTOP_SESSION" ];then
    eval $(gnome-keyring-daemon --start)
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

PS1='[\u@\h \W]\$ '
#resetcolor="$(tput sgr0)"
#PS1='\[\e]0;\w\a\]\n\[\e[32m\]\u@\h \[\e[33m\]\w\n${resetcolor}\$ '


export OMP_NUM_THREADS=1

export EDITOR=vim

#export DISTCC_HOSTS="deepthought/5,lzo,cpp archpc/9,lzo,cpp"


#CoDiPack

# JAVA
# Make Java use anti-aliasing for nicer fonts
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"

MY_SSH_OPTIONS=-AYC



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
    module load preCICE/1.3-Debug-PETSc-Python

    module load CoDiPack/1.7
    module load Togl/1.7
    module load NGSolve/5.0.0-opt


#    module load miniconda3/Latest
    module load pdfsam
    # Eigen
#    export CPLUS_INCLUDE_PATH="/usr/include/eigen3:$CPLUS_INCLUDE_PATH"

    # PETSc
#    export PETSC_DIR=/usr/lib/petscdir/3.7
#    export PETSC_DIR=/usr/lib/x86_64-linux-gnu/
#    export PETSC_DIR=/usr/lib/petscdir/3.7.7/x86_64-linux-gnu-real
#    export PETSC_ARCH=""
#    export PETSC_ARCH=x86_64-linux-gnu-real
#    export LD_LIBRARY_PATH=$PETSC_DIR/lib:$LD_LIBRARY_PATH
#    export CPATH=$PETSC_DIR/include:$CPATH
#    export LIBRARY_PATH=$PETSC_DIR/lib:$LIBARYhiPATH
#    export PYTHONPATH=$PETSC_DIR/lib:$PYTHONPATH
#    export TERM=rxvt-unicode-256color

#    export PRECICE_ROOT=/home/jaustar/projects/precice/precice-1.3.0
#    export LD_LIBRARY_PATH=${PRECICE_ROOT}/build/debug:${LD_LIBRARY_PATH}

#    export SU2_RUN=/home/jaustar/software/su2/SU2-6.0.0-install/bin
#    export SU2_HOME=/home/jaustar/software/su2/SU2-6.0.0
    
#    export PATH=$PATH:${SU2_RUN}
#    export PYTHONPATH=$SU2_RUN:${PYTHONPATH}

#    export SOFTWAREBASEDIR=${HOME}/software

#    export NETGENDIR=${SOFTWAREBASEDIR}/installed/netgen-5.0.0-opt/bin
#    export PATH=${NETGENDIR}:${PATH}
#    export LD_LIBRARY_PATH=${NETGENDIR}/../lib:${LD_LIBRARY_PATH}
#    export CPATH=${NETGENDIR}/../include:${CPATH}

#    export LD_LIBRARY_PATH=/home/jaustar/software/installed/Togl-1.7/lib:${LD_LIBRARY_PATH}
#    export CPATH=/home/jaustar/software/installed/Togl-1.7/include:${CPATH}

#    export CODIPACKDIR=/home/jaustar/software/installed/CoDiPack-1.7

    # Calculix adapter
    export PATH=/home/jaustar/software/calculix-adapter-master/bin/:${PATH}
    # yaml for calculix adapter
    export LD_LIBRARY_PATH=/home/jaustar/software/yaml-cpp-yaml-cpp-0.6.2/build:${LD_LIBRARY_PATH}
    export CPLUS_INCLUDE_PATH=/home/jaustar/software/yaml-cpp-yaml-cpp-0.6.2/include:${CPLUS_INCLUDE_PATH}

    # OpenFOAM
    . /opt/openfoam5/etc/bashrc
#    export LD_LIBRARY_PATH=${SOFTWAREBASEDIR}/SPOOLES.2.2/
#    export SPOOLESDIR=
    # JabRef
#    alias jabref="java -jar /home/jaustar/software/jabref/JabRef-4.3.1.jar"
    alias jabref="/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin/java -jar /home/jaustar/software/jabref/JabRef-4.3.1.jar"
  ;;
  (*) 
    export CODIPACKDIR=/opt/CoDiPack
  ;;
esac

if [ "$COLORTERM" == "xfce4-terminal" ] ; then
    export TERM=xterm-256color
fi

alias rm="rm -i"
alias grep="grep --color"
alias ls="ls --color"
alias ll='ls -lah'
alias ln='ln -i'
alias h='history'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias reactiveKeyboardToggle='setxkbmap -model pc105 -layout de,us -option grp:alt_space_toggle'


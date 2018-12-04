#
# ~/.bashrc
#

# Source standard bashrc
case $HOSTNAME in
  (CRD-L-05716) source /etc/bash.bashrc;;
  (*) ;;
esac

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

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


alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


export OMP_NUM_THREADS=1

export EDITOR=vim

#export DISTCC_HOSTS="deepthought/5,lzo,cpp archpc/9,lzo,cpp"


#CoDiPack
export CODIPACKDIR=/opt/CoDiPack

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
    # Eigen
    export CPLUS_INCLUDE_PATH="/usr/include/eigen3:$CPLUS_INCLUDE_PATH"

    # PETSc
    export PETSC_DIR=/usr/lib/petscdir/3.7
    export LD_LIBRARY_PATH=$PETSC_DIR/lib:$LD_LIBRARY_PATH
    export CPATH=$PETSC_DIR/include:$CPATH
    export LIBRARY_PATH=$PETSC_DIR/lib:$LIBARY_PATH
    export PYTHONPATH=$PETSC_DIR/lib:$PYTHONPATH
#    export TERM=rxvt-unicode-256color

    export PRECICE_ROOT=/home/jaustar/projects/precice/precice-1.3.0
    export LD_LIBRARY_PATH=${PRECICE_ROOT}/build/last:${LD_LIBRARY_PATH}

    export SU2_RUN=/home/jaustar/software/su2/SU2-6.0.0-install/bin
    export SU2_HOME=/home/jaustar/software/su2/SU2-6.0.0
    
    export PATH=$PATH:${SU2_RUN}
    export PYTHONPATH=$SU2_RUN:${PYTHONPATH}
  ;;
  (*) ;;
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


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


alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


export OMP_NUM_THREADS=1

export EDITOR=vim

#export DISTCC_HOSTS="deepthought/5,lzo,cpp archpc/9,lzo,cpp"
export DISTCC_HOSTS="deepthought/5,lzo,cpp"


#CoDiPack
export CODIPACKDIR=/opt/CoDiPack

# JAVA
# Make Java use anti-aliasing for nicer fonts
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true"

#archey3

VSC_USERID=vsc31571
U_USERID=u0120326
X_USERID=x0120326

TIER2_LOGIN_NODE1=login.hpc.kuleuven.be
TIER2_LOGIN_NODE2=login2.hpc.kuleuven.be

TIER1_LOGIN_NODE1=login1-tier1.hpc.kuleuven.be
TIER1_LOGIN_NODE2=login2-tier1.hpc.kuleuven.be

GENIUS_LOGIN_NODE1=login1-tier2.hpc.kuleuven.be
GENIUS_LOGIN_NODE2=login2-tier2.hpc.kuleuven.be
GENIUS_LOGIN_NODE3=login3-tier2.hpc.kuleuven.be
GENIUS_LOGIN_NODE4=login4-tier2.hpc.kuleuven.be

BATCH_LOGIN_NODE=tier2-p-batch-1.icts.hpc.kuleuven.be

MY_SSH_OPTIONS=-AYC

alias matlabJAVA8="echo 'Starting Matlab with Java 8';MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre/  matlab"
#alias matlab='MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre/  matlab -softwareopengl' 

alias thinkingVSCuserLogin1="ssh ${MY_SSH_OPTIONS} ${VSC_USERID}@${TIER2_LOGIN_NODE1}"
alias thinkingVSCuserLogin2="ssh ${MY_SSH_OPTIONS} ${VSC_USERID}@${TIER2_LOGIN_NODE2}"

alias thinkingUuserLogin1="ssh ${MY_SSH_OPTIONS} ${U_USERID}@${TIER2_LOGIN_NODE1}"
alias thinkingUuserLogin2="ssh ${MY_SSH_OPTIONS} ${U_USERID}@${TIER2_LOGIN_NODE2}"

alias thinkingXuserLogin1="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${TIER2_LOGIN_NODE1}"
alias thinkingXuserLogin2="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${TIER2_LOGIN_NODE2}"

alias breniacXuserLogin1="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${TIER1_LOGIN_NODE1}"
alias breniacXuserLogin2="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${TIER1_LOGIN_NODE2}"

alias breniacVSCuserLogin1="ssh ${MY_SSH_OPTIONS} ${VSC_USERID}@${TIER1_LOGIN_NODE1}"
alias breniacVSCuserLogin2="ssh ${MY_SSH_OPTIONS} ${VSC_USERID}@${TIER1_LOGIN_NODE2}"

alias geniusXuserLogin1="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${GENIUS_LOGIN_NODE1}"
alias geniusXuserLogin2="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${GENIUS_LOGIN_NODE2}"
alias geniusXuserLogin3="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${GENIUS_LOGIN_NODE3}"
alias geniusXuserLogin4="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${GENIUS_LOGIN_NODE4}"

alias geniusVSCuserLogin1="ssh ${MY_SSH_OPTIONS} ${VSC_USERID}@${GENIUS_LOGIN_NODE1}"
alias geniusVSCuserLogin2="ssh ${MY_SSH_OPTIONS} ${VSC_USERID}@${GENIUS_LOGIN_NODE2}"
alias geniusVSCuserLogin3="ssh ${MY_SSH_OPTIONS} ${VSC_USERID}@${GENIUS_LOGIN_NODE3}"
alias geniusVSCuserLogin4="ssh ${MY_SSH_OPTIONS} ${VSC_USERID}@${GENIUS_LOGIN_NODE4}"

alias batchXuserLogin="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${BATCH_LOGIN_NODE}"


alias rm="rm -i"
alias grep="grep --color"
alias ls="ls --color"


# Enable X-forwarding on windows subsystem
case $HOSTNAME in
  (CRD-L-05716) export DISPLAY=127.0.0.1:0
#    export TERM=rxvt-unicode-256color
  ;;
  (archpc)
    export NETGENDIR=/opt/netgen-5.0.0-opt/bin
    export PATH=${NETGENDIR}:${PATH}
    export LD_LIBRARY_PATH=${NETGENDIR}/../lib:$LD_LIBRARY_PATH
    export PETSC_DIR=/opt/petsc-3.6.1-opt
    export LD_LIBRARY_PATH=${PETSC_DIR}/lib:$LD_LIBRARY_PATH

    export DISTCC_HOSTS="localhost/9,lzo,cpp deepthought/5,lzo,cpp"
    ;;

  (*) ;;
esac

if [ "$COLORTERM" == "xfce4-terminal" ] ; then
    export TERM=xterm-256color
fi


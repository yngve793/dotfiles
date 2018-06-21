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

alias thinking_VSCuserLogin1="ssh ${MY_SSH_OPTIONS} ${VSC_USERID}@${TIER2_LOGIN_NODE1}"
alias thinking_VSCuserLogin2="ssh ${MY_SSH_OPTIONS} ${VSC_USERID}@${TIER2_LOGIN_NODE2}"

alias thinking_UuserLogin1="ssh ${MY_SSH_OPTIONS} ${U_USERID}@${TIER2_LOGIN_NODE1}"
alias thinking_UuserLogin2="ssh ${MY_SSH_OPTIONS} ${U_USERID}@${TIER2_LOGIN_NODE2}"

alias thinking_XuserLogin1="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${TIER2_LOGIN_NODE1}"
alias thinking_XuserLogin2="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${TIER2_LOGIN_NODE2}"

alias breniac_XuserLogin1="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${TIER1_LOGIN_NODE1}"
alias breniac_XuserLogin2="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${TIER1_LOGIN_NODE2}"

alias genius_XuserLogin1="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${GENIUS_LOGIN_NODE1}"
alias genius_XuserLogin2="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${GENIUS_LOGIN_NODE2}"
alias genius_XuserLogin3="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${GENIUS_LOGIN_NODE3}"
alias genius_XuserLogin4="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${GENIUS_LOGIN_NODE4}"

alias batch_XuserLogin="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${BATCH_LOGIN_NODE}"

alias rm="rm -i"

# Enable X-forwarding on windows subsystem
case $HOSTNAME in
  (CRD-L-05716) export DISPLAY=127.0.0.1:0
  #export TERM=rxvt-unicode-256color
  ;;
  (*) ;;
esac

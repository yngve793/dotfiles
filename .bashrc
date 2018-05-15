#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#Start ssh-agent
#This also takes care that only one ssh-agent is running. I don't know if this conflicts with gnome.
#https://wiki.archlinux.org/index.php/SSH_keys#ssh-agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > ~/.ssh-agent-thing
fi
if [[ "$SSH_AGENT_PID" == "" ]]; then
    eval "$(<~/.ssh-agent-thing)"
fi

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '


export OMP_NUM_THREADS=1

#export MATLABLIBDIR=/usr/local/MATLAB/R2016b/bin/glnxa64
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$MATLABLIBDIR

export EDITOR=emacs
#export NETGENDIR=/opt/netgen-5.0.0-opt/bin
#export NETGENLIBDIR=/opt/netgen-5.0.0-opt/lib
#export NETGENDIR=/opt/netgen-5.0.0-opt/bin
#export NETGENLIBDIR=/opt/netgen-5.0.0-opt/lib
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NETGENLIBDIR
#export NETGENDIR=/opt/netgen-mpi/bin
#export PETSC_DIR=/opt/petsc-gcc-debug/
#export PETSC_DIR=/opt/petsc-3.7.2-opt/

#export LIBTOGLDIR=/opt/Togl-1.7
#export TCLLIBPATH=/opt/Togl-1.7/lib
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$PETSC_DIR/lib/:/opt/Togl-1.7/lib
#export PATH=$PATH:$NETGENDIR

#export DISTCC_HOSTS="deepthought/5,lzo,cpp archpc/9,lzo,cpp"
export DISTCC_HOSTS="deepthought/5,lzo,cpp"


#CoDiPack
#export CODI_PATH=/opt/CoDiPack
export CODIPACKDIR=/opt/CoDiPack
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/CoDiPack/include

#archey3

VSC_USERID=vsc31571
U_USERID=u0120326
X_USERID=x0120326

TIER2_LOGIN_NODE1=login.hpc.kuleuven.be
TIER2_LOGIN_NODE2=login2.hpc.kuleuven.be

TIER1_LOGIN_NODE1=login1-tier1.hpc.kuleuven.be
TIER1_LOGIN_NODE2=login2-tier1.hpc.kuleuven.be

BATCH_LOGIN_NODE=tier2-p-batch-1.icts.hpc.kuleuven.be

MY_SSH_OPTIONS=-AYC

alias asdf="echo 'asdf'"

alias matlabJAVA8="echo 'Starting Matlab with Java 8';MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre/  matlab"
#alias matlab='MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre/  matlab -softwareopengl' 

alias ssh_leuven1="ssh ${MY_SSH_OPTIONS} ${VSC_USERID}@${TIER2_LOGIN_NODE1}"
alias ssh_leuven2="ssh ${MY_SSH_OPTIONS} ${VSC_USERID}@${TIER2_LOGIN_NODE2}"

alias ssh_VSCleuven1="ssh ${MY_SSH_OPTIONS} ${U_USERID}@${TIER2_LOGIN_NODE1}"
alias ssh_VSCleuven2="ssh ${MY_SSH_OPTIONS} ${U_USERID}@${TIER2_LOGIN_NODE2}"

alias ssh_XUserleuven1="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${TIER2_LOGIN_NODE1}"
alias ssh_XUserleuven2="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${TIER2_LOGIN_NODE2}"

alias tier1_login="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${TIER1_LOGIN_NODE1}"
alias tier1_login2="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${TIER1_LOGIN_NODE2}"

alias sshBatch="ssh ${MY_SSH_OPTIONS} ${X_USERID}@${BATCH_LOGIN_NODE}"

alias rm="rm -i"

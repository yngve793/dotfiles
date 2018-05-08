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

alias asdf="echo 'asdf'"

alias matlabJAVA8="echo 'Starting Matlab with Java 8';MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre/  matlab"
#alias matlab='MATLAB_JAVA=/usr/lib/jvm/java-8-openjdk/jre/  matlab -softwareopengl' 

alias ssh_leuven="ssh -YC vsc31571@login.hpc.kuleuven.be"
alias ssh_leuven2="ssh -YC vsc31571@login2.hpc.kuleuven.be"

alias ssh_leuven_noX="ssh -C vsc31571@login.hpc.kuleuven.be"
alias ssh_leuven2_noX="ssh -C vsc31571@login2.hpc.kuleuven.be"

alias ssh_VSCleuven="ssh -YC u0120326@login.hpc.kuleuven.be"
alias ssh_VSCleuvenXuser="ssh -YC x0120326@login.hpc.kuleuven.be"

alias tier1='ssh -YC x0120326@login1-tier1.hpc.kuleuven.be'
alias tier1a='ssh -YC x0120326@login2-tier1.hpc.kuleuven.be'

alias sshBatch='ssh -YC x0120326@tier2-p-batch-1.icts.hpc.kuleuven.be'

alias rm="rm -i"

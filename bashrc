#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


for file in /etc/profile.d/modules.sh /etc/profile /etc/bash.bashrc /usr/local.nfs/rc/bashrc ~/.git-{completion.bash,prompt.sh} ~/.svn-prompt.sh ~/.bash_{exports,aliases,functions,prompt} ~/.fzf.bash /usr/share/fzf/*.bash /usr/share/git/completion/git-{completion.bash,prompt.sh} ${HOME}/.cargo/env  ${HOME}/bin/git-annex.linux/bash/git-completion.bash "$HOME/.cargo/env"
do
    if [[ -f "$file" ]]
    then
        source "$file"
    fi
done

# enable bash completion in interactive shells
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi


for dir in /data/scratch/jaustar/software/spack /data/scratch/sgs/jaustar/spack /scratch-nfs/jaustar/software/spack
do
    if [[ -d "$dir" ]]
    then
      export SPACK_ROOT="$dir"
      . $SPACK_ROOT/share/spack/setup-env.sh
    fi
done

case $HOSTNAME in
  lapsgs24)
    module load CoDiPack/1.7
    module load Togl/1.7
    module load NGSolve/5.0.0-opt

    module load pdfsam
    ;;
  (*)
    case ${HOSTNAME} in
      *)
      ;;
    esac
  ;;
esac

#. "$HOME/.cargo/env"

eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH=$PATH:/usr/local/bin

source ~/.git-prompt.sh

function color_my_prompt {
    local __user_and_host="\[\033[01;32m\]\u@\h"
    local __cur_location="\[\033[01;34m\]\w"
    local __git_branch_color="\[\033[31m\]"
    #local __git_branch="\`ruby -e \"print (%x{git branch 2> /dev/null}.grep(/^\*/).first || '').gsub(/^\* (.+)$/, '(\1) ')\"\`"
    local __git_branch='`git branch 2> /dev/null | grep -e ^* | sed -E  s/^\\\\\*\ \(.+\)$/\(\\\\\1\)\ /`'
    local __prompt_tail="\[\033[35m\]$"
    local __last_color="\[\033[00m\]"
    export PS1="$__user_and_host $__cur_location $__git_branch_color$__git_branch$__prompt_tail$__last_color "
}
color_my_prompt

parse_git_bg() {
  if [[ $(git status -s 2> /dev/null) ]]; then
    echo -e "\033[0;31m"
  else
    echo -e "\033[0;32m"
  fi
}

# export PS1="\u\[\033[1;34m\]@\h\[\033[0m\]:\[\033[0;32m\]\w\[\033[0;32m\]\$(__git_ps1)\n└─(\[\033[1;32m\]\t, \$(ls -1 | wc -l | sed 's: ::g') files, \$(ls -sh | head -n1 | sed 's/total //')b\[\033[1;37m\]\[\033[0;32m\])\342\224\200>\[\033[0m\] "
# export PS1="\u\[\033[1;34m\]@\h\[\033[0m\]:\[\033[0;32m\]\w\[\033[0;32m\]$(parse_git_bg)$(__git_ps1)\n\[\033[0;32m\]└─(\[\033[1;32m\]\t, \$(ls -1 | wc -l | sed 's: ::g') files, \$(ls -sh | head -n1 | sed 's/total //')b\[\033[1;37m\]\[\033[0;32m\])\342\224\200>\[\033[0m\] "
export PS1="\u\[\033[1;34m\]@\h\[\033[0m\]:\[\033[0;32m\]\w\[\033[0;32m\]\$(parse_git_bg)\$(__git_ps1)\n\[\033[0;32m\]└─(\[\033[1;32m\]\t\$(ls -1 | wc -l | sed 's: ::g') files, \$(ls -sh | head -n1 | sed 's/total //')b\[\033[1;37m\]\[\033[0;32m\])\342\224\200>\[\033[0m\] "


[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}

source /opt/homebrew/opt/lmod/init/bash
export MODULEPATH=/Users/YVI/software/modules:$MODULEPATH
module load openvds
module load brew_default

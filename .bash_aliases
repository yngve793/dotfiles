alias rm="rm -i"
alias grep="grep --color"
alias ls='ls --color=auto'
alias ll='ls -lah'
alias l="ls"
alias ln='ln -i'
alias h='history'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias reactiveKeyboardToggle='setxkbmap -model pc105 -layout de,us -option grp:alt_space_toggle'
alias df="df -h"
alias ml="module list"
alias ma="module av"

case $HOSTNAME in
  (lapsgs24)
    alias jabref="/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin/java -jar /home/jaustar/software/jabref/JabRef-4.3.1.jar"\
  ;;
  (*)
  ;;
esac

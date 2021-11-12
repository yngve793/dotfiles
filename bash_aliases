#!/usr/bin/env bash

alias rm="rm -i"
alias grep="grep --color"
alias ls='ls --color=auto'
alias ll='ls -lah'
alias l="ls"
alias ln='ln -i'
alias la='ls -A'
alias h='history'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias reactiveKeyboardToggle='setxkbmap -model pc105 -layout de,us -option grp:alt_space_toggle'
alias df="df -h"
alias ml="module list"
alias ma="module av"
alias tree="tree -C"
alias less='less -R'

case $HOSTNAME in
  (lapsgs24)
    #alias jabref="/usr/lib/jvm/java-1.8.0-openjdk-amd64/bin/java -jar /home/jaustar/software/jabref/JabRef-4.3.1.jar"
    alias jabref="/home/jaustar/software/jabref/JabRef/bin/JabRef"
    alias qtcreator="/home/jaustar/software/qtcreator-4.10.1/bin/qtcreator.sh"
  ;;
  (*)
  ;;
esac

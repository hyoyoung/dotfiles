# path
set -x PATH /usr/local/bin $PATH

# editor
set -x EDITOR vim

# cmd prompt
export PS1="\u@\h:\w\$ "

# Tell ls to be colourful
set -x CLICOLOR 1
set -x LSCOLORS "ExGxBxDxCxEgEdxbxgacxd"

# Tell grep to highlight matches
set -x GREP_OPTIONS '--color=auto'

# java dir path
set -x JAVA_HOME  (/usr/libexec/java_home)

alias ls='ls -Fh'

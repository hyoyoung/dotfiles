# path
set -x PATH $HOME/ulocal/bin /usr/local/bin $PATH

# golang
set -x GOPATH /Users/morris/ulocal/go
set -x GOROOT /usr/local/opt/go/libexec
set -x PATH $PATH /usr/local/opt/go/libexec $GOPATH/bin $GOROOT/bin /usr/local/opt/llvm/bin

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

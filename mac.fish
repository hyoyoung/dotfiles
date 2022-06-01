# path
set -x PATH /usr/local/sbin $PATH
set -x PATH /opt/homebrew/sbin /opt/homebrew/bin $PATH
set -x PATH $HOME/local/bin $PATH
# brew utils
set -x PATH /opt/homebrew/opt/sbt@0.13/bin $PATH
set -x PATH /opt/homebrew/opt/scala@2.12/bin $PATH

# golang
set -x GOPATH /Users/hyoyoung/local/go
set -x GOROOT /opt/homebrew/opt/go/libexec
set -x PATH $PATH $GOPATH/bin $GOROOT/bin

# ncc
set -x PATH $PATH /Users/hyoyoung/local/ncc

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
#set -x JAVA_HOME  (/usr/libexec/java_home)

# add password manager
# source /usr/local/share/fish/vendor_completions.d/pass.fish

alias ls='ls -Fh'
alias vi='vim'

# path
set -x PATH $HOME/local/bin $PATH
# brew utils
set -x PATH /usr/local/opt/scala@2.11/bin $PATH
set -x PATH /usr/local/opt/curl/bin $PATH
set -x PATH /usr/local/opt/llvm/bin $PATH
set -x PATH /usr/local/opt/openssl/bin $PATH

# golang
set -x GOPATH /Users/hyoyoung/local/go
set -x GOROOT /usr/local/opt/go/libexec
set -x PATH $PATH $GOPATH/bin $GOROOT/bin

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
source /usr/local/share/fish/vendor_completions.d/pass.fish

alias ls='ls -Fh'
alias vi='vim'

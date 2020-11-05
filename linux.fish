# path
set -x PATH $PATH /usr/local/bin

# golang
set -x GOPATH /home/hyoyoung/local/go
set -x GOROOT /usr/lib/go
set -x PATH $PATH $GOPATH/bin $GOROOT/bin

# editor
set -x EDITOR vim

set -x PS1 "\u@\h:\w\$ "

# read dircolors
eval (dircolors -c)

# Tell grep to highlight matches
#set -x GREP_OPTIONS '--color=auto'

# java dir path
#set -x JAVA_HOME  (/usr/libexec/java_home)

alias ls='ls --color=auto'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

alias sysupdate='sudo apt-get update && sudo apt-get dselect-upgrade -y && sudo apt-get clean'
alias open='xdg-open'
alias chrome_hidpi='chromium-browser --force-device-scale-factor=2'
# alias setxkbmap_nocaps='setxkbmap -layout us -option ctrl:nocaps'
# left hand mouse
# dconf read /org/gnome/desktop/peripherals/mouse/left-handed true

# activate conda
# set -x PATH $PATH /home/hyoyoung/local/anaconda3/bin
# source (conda info --root)/etc/fish/conf.d/conda.fish

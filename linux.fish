# path
#set -x PATH /usr/local/bin $PATH

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

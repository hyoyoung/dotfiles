#!/bin/bash

#########################
# system dependent part #
#########################
init_linux_conf() {
    # add sbin for default ubuntu setting
    PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

    # term set
    if [ "$COLORTERM" == "gnome-terminal" ] || [ "$COLORTERM" == "xfce4-terminal" ]
    then
        TERM=xterm-256color
    elif [ "$COLORTERM" == "rxvt-xpm" ]
    then
        TERM=rxvt-256color
    fi

    alias sysupdate='sudo apt-get update && sudo apt-get dselect-upgrade -y && sudo apt-get clean'
    alias mketags='find . -name "*.[chCH]" -print | etags -'
    alias nvmplayer='mplayer -ao alsa -zoom -quiet -fs -vo vdpau -vc ffh264vdpau,ffmpeg12vdpau,ffwmv3vdpau,ffvc1vdpau,'
    
    # add export
    export EDITOR=vi
    export MAKEFLAGS=-j5
}

init_darwin_conf() {
    # path
    export PATH=/usr/local/bin:$PATH
    
    # cmd prompt
    export PS1="\u@\h:\w\$ "
    
    # Tell ls to be colourful
    export CLICOLOR=1
    export LSCOLORS="ExGxBxDxCxEgEdxbxgacxd"
    
    # Tell grep to highlight matches
    export GREP_OPTIONS='--color=auto'
    
    # add bash completion
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
    fi
    
    # java dir path
    export JAVA_HOME=$(/usr/libexec/java_home)

    alias ls='ls -Fh'
    alias ll='ls -l'
}

if [ "$(uname)" == "Darwin" ]; then
    init_darwin_conf
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    init_linux_conf
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    echo "Cygwin"
fi

###############
# common part #
################
alias df='df -h'
alias du='du -h'

# add useful aliases
alias h='history 100'
alias g='grep'
alias r='reset'
alias tnew='tmux new-session -s $USER'
alias tadd='tmux attach || tmux'
alias tls='tmux list-sessions'

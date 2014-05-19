#!/bin/bash

# common part
alias ls='ls -Fh'
alias ll='ls -l'
alias la='ls -a'
alias le='ls -al'
alias lr='ls -lR'

alias df='df -h'
alias du='du -sh'

# add useful aliases
alias h='history 100'
alias g='grep'

# system dependent part
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
    # add mac conf
    :
}

if [ "$(uname)" == "Darwin" ]; then
    init_darwin_conf
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    init_linux_conf
elif [ "$(expr substr $(uname -s) 1 10)" == "MINGW32_NT" ]; then
    echo "Cygwin"
fi

    # path
    set -x PATH /usr/local/bin $PATH

    # cmd prompt
    #export PS1="\u@\h:\w\$ "

    # Tell ls to be colourful
    set -x CLICOLOR 1
    set -x LSCOLORS "ExGxBxDxCxEgEdxbxgacxd"

    # Tell grep to highlight matches
    set -x GREP_OPTIONS '--color=auto'

    # java dir path
    set -x JAVA_HOME  (/usr/libexec/java_home)

    alias ls='ls -Fh'

###############
# common part #
################
alias df='df -h'
alias du='du -h'

# add useful aliases
alias h='history 100'
alias g='grep'
alias r='reset'
alias tmnew='tmux new-session -s $USER'
alias tmat='tmux attach; or tnew'
alias tmls='tmux list-sessions'

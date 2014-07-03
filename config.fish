function prompt_pwd --description 'Print the current working directory, NOT shortened to fit the prompt'
        if test "$PWD" != "$HOME"
                printf "%s" (echo $PWD|sed -e 's|/private||' -e "s|^$HOME|~|")
        else
                echo '~'
        end

end

function fish_prompt --description 'Write out the prompt'

        # Just calculate these once, to save a few cycles when displaying the prompt
        if not set -q __fish_prompt_hostname
                set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
        end

        if not set -q __fish_prompt_normal
                set -g __fish_prompt_normal (set_color normal)
        end

        switch $USER

                case root

                if not set -q __fish_prompt_cwd
                        if set -q fish_color_cwd_root
                                set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
                        else
                                set -g __fish_prompt_cwd (set_color normal)
                        end
                end

                echo -n -s "$USER" @ "$__fish_prompt_hostname" ':' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" '# '

                case '*'

                if not set -q __fish_prompt_cwd
                        set -g __fish_prompt_cwd (set_color normal)
                end

                echo -n -s "$USER" @ "$__fish_prompt_hostname" ':' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" '$ '

        end
end

    # path
    set -x PATH /usr/local/bin $PATH

    # editor
    set -x EDITOR vim

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

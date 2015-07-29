# fish config

function prompt_pwd --description 'Print the current working directory, NOT shortened to fit the prompt'
        if test "$PWD" != "$HOME"
                printf "%s" (echo $PWD|sed -e 's|/private||' -e "s|^$HOME|~|")
        else
                echo '~'
        end

end

set -g __fish_git_prompt_show_informative_status 1
set -g __fish_git_prompt_hide_untrackedfiles 1

set -g __fish_git_prompt_color_branch magenta
set -g __fish_git_prompt_showupstream "informative"
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"

set -g __fish_git_prompt_color_dirtystate blue
set -g __fish_git_prompt_color_stagedstate yellow
set -g __fish_git_prompt_color_invalidstate red
set -g __fish_git_prompt_color_untrackedfiles $fish_color_normal
set -g __fish_git_prompt_color_cleanstate normal

function fish_prompt --description 'Write out the prompt'

        set -l last_status $status

        # Just calculate these once, to save a few cycles when displaying the prompt
        if not set -q __fish_prompt_hostname
                set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
        end

        if not set -q __fish_prompt_normal
                set -g __fish_prompt_normal (set_color normal)
        end

        if not set -q -g __fish_classic_git_functions_defined
                set -g __fish_classic_git_functions_defined
                function __fish_repaint_user --on-variable fish_color_user --description "Event handler, repaint when fish_color_user changes"
                        if status --is-interactive
                                set -e __fish_prompt_user
                                commandline -f repaint ^/dev/null
                        end
                end
                function __fish_repaint_host --on-variable fish_color_host --description "Event handler, repaint when fish_color_host changes"
                        if status --is-interactive
                                set -e __fish_prompt_host
                                commandline -f repaint ^/dev/null
                        end
                end
                function __fish_repaint_status --on-variable fish_color_status --description "Event handler; repaint when fish_color_status changes"
                        if status --is-interactive
                                set -e __fish_prompt_status
                                commandline -f repaint ^/dev/null
                        end
                end
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

                echo -n -s "$USER" @ "$__fish_prompt_hostname" ':' "$__fish_prompt_cwd" (prompt_pwd) (__fish_git_prompt) "$__fish_prompt_normal" '$ '
        end
end

###############
# common part #
################
alias df='df -h'
alias du='du -h'

# add useful aliases
alias h='history | head -n 25'
alias g='grep'
alias r='reset'
alias tmnew='tmux new-session -s $USER'
alias tmat='tmux attach; or tnew'
alias tmls='tmux list-sessions'

# OS-specific customizations
if [ (uname) = 'Darwin' ]
    source ~/.config/fish/mac.fish
else if [ (uname) = 'Linux' ]
    source ~/.config/fish/linux.fish
end

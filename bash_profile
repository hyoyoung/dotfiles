# This file is for non-linux environment. don't use at linux
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# read additional shell conf file
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

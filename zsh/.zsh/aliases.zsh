# -*- mode: sh; eval: (sh-set-shell "zsh") -*-

# Defines local aliases
#
# Authors:
#   David Crook <david.crook@gmail.com>


# https://hub.github.com/
# brew install hub || sudo snap install hub --classic
if [[ -x /usr/local/bin/hub || -x /snap/bin/hub ]]
then
    # eval "$(hub alias -s)"
	alias git=hub
fi

# create "global" alias
alias -g L="| less"   # example: cat README.md L 

case "$OSTYPE" in
    # macOS commands go here
    darwin*)
        # Use Marked 2.app from command line
        alias mo="open -a 'Marked 2.app'"
        # Use Marked 2.app for .md files (a suffix alias)
        alias -s md="open -a 'Marked 2.app'"
    ;;
    # commands for Linux go here
    linux*)
    ;;
    # commands for BSD-s go here
    dragonfly*|freebsd*|netbsd*|openbsd*)
    ;;
esac

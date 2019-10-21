# -*- mode: sh; eval: (sh-set-shell "zsh") -*-

# Defines local aliases
#
# Authors:
#   David Crook <david.crook@gmail.com>


case $OSTYPE in
    darwin*)
        export EMACSCLIENT=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
        alias emacsclient=$EMACSCLIENT
        ;;
    *)
        export EMACSCLIENT=emacsclient
        ;;
esac

# https://hub.github.com/
# brew install hub || sudo snap install hub --classic
if [[ -x /usr/local/bin/hub || -x /snap/bin/hub ]]
then
    # eval "$(hub alias -s)"
	alias git=hub
fi

# create "global" alias
alias -g L="| less"   # example: cat README.md L

case "$OSTYPE" in
    # macOS commands go here
    darwin*)
        # Use Marked 2.app from command line
        alias mo="open -a 'Marked 2.app'"
        # Use Marked 2.app for .md files (a suffix alias)
        alias -s md="open -a 'Marked 2.app'"

        # open
        # USAGE
        #      ne somefile:line
        # via https://www.reddit.com/r/emacs/comments/9sz0ql/make_emacs_open_files_at_specific_line_numbers_as/
        ne() {
            local args=()
            for arg in "$@" ; do
                # Replace line numbers specified with <FILE>:n into the +n <FILE> emacs syntax
                args+=($(echo $arg | sed -E 's/(.*):([0-9]+)/+\2 \1/'))
            done;
            Emacs.sh ${args[*]}
        }
    ;;
    # commands for Linux go here
    linux*)
    ;;
    # commands for BSD-s go here
    dragonfly*|freebsd*|netbsd*|openbsd*)
    ;;
esac


# https://stuff-things.net/2019/09/04/updated-emacs-open-with-line-numbers/
function ec () {
    setopt local_options KSH_ARRAYS BASH_REMATCH
    # Replace line numbers specified with <FILE>:n <FILE>:#Ln into the +n <FILE> emacs syntax
    if [[ $1 =~ (.*)[:#]L?([0-9]+)$ ]]; then
        # without KSH_ARRAYS # $EMACSCLIENT -c -n "+${BASH_REMATCH[3]}" "${BASH_REMATCH[2]}"
        # zsh equiv without KSH_ARRAYS, BASH_REMATCH #  $EMACSCLIENT -c -n "+${match[2]}" "${match[1]}"
        $EMACSCLIENT -c -n "+${BASH_REMATCH[2]}" "${BASH_REMATCH[1]}"
    else
        $EMACSCLIENT -c -n "$@"
    fi
}

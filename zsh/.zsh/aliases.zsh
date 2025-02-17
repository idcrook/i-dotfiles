# -*- mode: sh; eval: (sh-set-shell "zsh") -*-

# Defines local aliases
#
# Authors:
#   David Crook <david.crook@gmail.com>

## $XDG_CONFIG_HOME: $HOME/.config
if [[ ! -x "$XDG_CONFIG_HOME" ]]; then
  shell_config="$HOME/.config/shell"
else
  shell_config="$XDG_CONFIG_HOME/shell"
fi

# meta-aliases
alias sal='echo sourcing ~/.zsh/aliases.zsh ; source ~/.zsh/aliases.zsh'
alias val='vi ~/.zsh/aliases.zsh; sal'

# commenting out as it breaks git completions
# # https://hub.github.com/
# # brew install hub || sudo snap install hub --classic
# if (( $+commands[hub] ))
# then
# 	# `hub alias` sez...
#     eval "$(hub alias -s)"
# fi


# create "global" aliases
alias -g L="| less"   # example: cat README.md L
alias -g EL="|& less"   # example: cat README.md L

case "$OSTYPE" in
    # macOS commands go here
    darwin*)
        # Use Marked 2.app from command line
        alias mo="open -a 'Marked 2.app'"
        # Use Marked 2.app for .md files (a suffix alias)
        alias -s md="open -a 'Marked 2.app'"

        # https://harmtemolder.com/read-qr-codes-from-your-mac-screen/
        # # Select area of screen to decode info from contained qrcode to STDOUT
        # # - zbarimg: brew zbar
        # # - shred: brew coreutils
        # alias read-qr='screencapture -i $TMPDIR/screencapture.bmp && zbarimg -q --raw $TMPDIR/screencapture.bmp; shred -u $TMPDIR/screencapture.bmp'

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
        # https://github.com/alexmurray/emacs-snap/issues/10
        # function emacsnap () {
        #     /snap/bin/emacs $* 2>&1 1>/dev/null | grep -v Fontconfig | grep -v libgvfsdbus.so;
        # }
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


# per host environment variables
nodename=$(uname -n)
if [[ -f "${shell_config}"/alias.$nodename.sh ]] ; then
    # shellcheck source=/dev/null
    source "${shell_config}"/alias.$nodename.sh
fi

# some helpers for a problem I am seeing
function conda_enter () {
    # make sure our conda venv is at the begining of path
    if [ -d $CONDA_PREFIX/bin ] ; then
        path=( $CONDA_PREFIX/bin  $path )
    fi
}

function conda_exit () {
    # leave virtual env
    conda deactivate     2>/dev/null || :

    # https://www.reddit.com/r/zsh/comments/d7h7gb/how_to_remove_unwanted_path_entries/
    # echo $PATH
    # path=( ${path[@]:#*${CONDA_DEFAULT_ENV}/bin} )
}



# Navigation -------------------------------------------------------
# comment out to unmask zprezto utility module "open" alias
#alias o='cd ..'
alias ui='cd ..'
alias uii='cd ../..'
alias uiii='cd ../../..'
alias uiiii='cd ../../../..'

# set an explicit alias for Intel-based Homebrew; assumes macOS install
if [ -x "$(command -v brew)" ]; then
    alias ibrew="arch -x86_64 /usr/local/bin/brew"
fi

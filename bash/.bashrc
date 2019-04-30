# ~/.bashrc: executed by bash(1) for non-login shells.
# -*- bash -*-
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    # the PATH export is a workaround to have mosh-server found
    # (resides in /usr/local/bin/mosh-server on macOS Homebrew)
      *) export PATH="$PATH:/usr/local/bin" && return;;
esac

# another way to test that
# [ -z "$PS1" ] && return
# the PATH export is a workaround to have mosh-server found
# (resides in /usr/local/bin/mosh-server on macOS Homebrew)
# https://github.com/mobile-shell/mosh/issues/102#issuecomment-308291984
[ -z "$PS1" ] && export PATH="$PATH:/usr/local/bin" && return

# Config dir ------------------------------------------------------

## XDG config
if [[ ! -x "$XDG_CONFIG_HOME" ]]; then
    shell_config="$HOME/.config/shell"
else
    shell_config="$XDG_CONFIG_HOME/shell"
fi

if [[ ! -x "$shell_config" ]]; then
    mkdir -p "$shell_config"
fi

## XDG data
if [[ ! -x "$XDG_DATA_HOME" ]]; then
    shell_data="$HOME/.local/share/shell"
else
    shell_data="$XDG_DATA_HOME/shell"
fi

if [[ ! -x "$shell_data" ]]; then
    mkdir -p "$shell_data"
fi



# Path ------------------------------------------------------------

# very handy utility
modpath () {
    # shellcheck disable=2124
    modpathargs=${@+"$@"};
    # shellcheck source=.config/shell/modpath.sh
    source "${shell_config}/modpath.sh";
    unset modpathargs
}

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Misc -------------------------------------------------------------
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
# Only available in bash version 4
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# sudo apt install source-highlight
if [ -f /usr/share/source-highlight/src-hilite-lesspipe.sh ] ; then
    export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
    export LESS=' -R '
fi

# brew install source-highlight
if [ -f /usr/local/bin/src-hilite-lesspipe.sh ] ; then
    export LESSOPEN="| /usr/local/bin/src-hilite-lesspipe.sh %s"
    export LESS=' -R '
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        # shellcheck source=/dev/null
        source /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        # shellcheck source=/dev/null
        source /etc/bash_completion
    fi
fi

# kubectl bash completions
if hash kubectl 2>/dev/null; then
    # shellcheck source=/dev/null
    source <(kubectl completion bash)
fi

# docker completion on macOS (once per machine) - with Homebrew bash completion installed
####  https://docs.docker.com/docker-for-mac/#bash
# etc=/Applications/Docker.app/Contents/Resources/etc
# ln -s $etc/docker.bash-completion $(brew --prefix)/etc/bash_completion.d/docker
# ln -s $etc/docker-machine.bash-completion $(brew --prefix)/etc/bash_completion.d/docker-machine
# ln -s $etc/docker-compose.bash-completion $(brew --prefix)/etc/bash_completion.d/docker-compose

# via https://github.com/cykerway/complete-alias
# requires BASH 4
# mkdir ~/.bash_completion.d
# curl -o ~/.bash_completion.d/bash_complete-alias.sh  https://raw.githubusercontent.com/cykerway/complete-alias/master/completions/bash_completion.sh
if [ -f ~/.bash_completion.d/bash_complete-alias.sh ] ; then
    # shellcheck source=.bash_completion.d/bash_complete-alias.sh
    source ~/.bash_completion.d/bash_complete-alias.sh
fi

# http://beets.readthedocs.io/en/v1.4.7/reference/cli.html#shell-completion
# if hash beet 2>/dev/null; then
#     eval "$(beet completion)"
# fi
# to save time:
#     beet completion > .bash_completion.d/beet-completion.sh
if [ -f ~/.bash_completion.d/beet-completion.sh ] ; then
    # shellcheck source=.bash_completion.d/beet-completion.sh
    source ~/.bash_completion.d/beet-completion.sh
fi

# Google Cloud SDK on macOS
# brew cask info homebrew/cask/google-cloud-sdk
if [ -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ] ; then
    if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc ] ; then
        source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
    fi
fi

# some Mac OS X specific checks
if [  "$(uname -s)" == 'Darwin' ]
then
    # brew install bash-completion (BASH 3)
    if [ -f "$(brew --prefix)"/etc/bash_completion ]; then
        # shellcheck source=/dev/null
        source "$(brew --prefix)"/etc/bash_completion
    fi

    # brew install bash-completion@2 (BASH 4)
    if [ -f /usr/local/share/bash-completion/bash_completion ]; then
        # shellcheck source=/dev/null
        source /usr/local/share/bash-completion/bash_completion
    fi

    ### http://brettterpstra.com/2014/05/10/bash-and-dash/

    # Open argument in Dash
    function dash() {
        open "dash://$*"
    }

    function dman() {
        open "dash://man:$*"
    }

    # http://hints.macworld.com/article.php?story=20131226153018801
    # function man { if [ $# -eq 1 ] ; then open x-man-page://$1 ; elif [ $# -eq 2 ] ; then open x-man-page://$1/$2 ; fi }

fi


# bash completion settings (actually, these are readline settings) : bind -lv
bind "set completion-ignore-case on" # note: bind used instead of sticking these in .inputrc
bind "set bell-style none" # no bell
bind "set show-all-if-ambiguous On" # show list automatically, without double tab

# Prompts ----------------------------------------------------------
# # set variable identifying the chroot you work in (used in the prompt below)
# if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
#     debian_chroot=$(cat /etc/debian_chroot)
# fi

# https://github.com/b-ryan/powerline-shell
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

# need to look for this, otherwise tramp session to linux hangs
case "$TERM" in
    xterm-color|*-256color)     PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND" ;;
esac

export PS2='> '    # Secondary prompt
export PS3='#? '   # Prompt 3
export PS4='+'     # Prompt 4

# Have to do iTerm2 shell integration after powerline-shell as it messes with
# prompt

# only source if we are a smarter shell (and on macOS)
if [ "$(uname -s)" == 'Darwin' ]
then
    # shellcheck source=/dev/null
    [ "$TERM" == 'xterm-256color' ] && test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
    # echo -n ""
fi

# Alias definitions. ----------------------------------------------

#
# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    # shellcheck source=.bash_aliases
    source ~/.bash_aliases
fi

# source bash aliases with secrets
if [ -f ~/.bash_aliases.op-secret.sh ]; then
    # will contain an alias like opeval="eval \$(op signin <signinaddress> <emailaddress> <secretkey>)"
    # shellcheck source=/dev/null
    source ~/.bash_aliases.op-secret.sh
fi

# Editors ----------------------------------------------------------
#export EDITOR='emacsclient --tty'
# if [ -z "$DISPLAY" ] ; then
#     export EDITOR='emacsclient -a vim --tty'
# else
#     export EDITOR='emacsclient -a vim --create-frame'
# fi

# create new frame in windowing env
if hash vim 2&>/dev/null ; then
    export EDITOR='emacsclient -a vim --create-frame'
else
    export EDITOR='emacsclient -a vi --create-frame'
fi
export VISUAL=$EDITOR


# set up python for interactive
if [ -f "$HOME"/.pystartup ]; then
    export PYTHONSTARTUP=$HOME/.pystartup
fi

# source local configurations
if [[ -r "$shell_config/local.sh" ]]; then
    # shellcheck disable=1090
    source "$shell_config/local.sh"
fi

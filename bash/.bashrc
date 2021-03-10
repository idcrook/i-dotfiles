# ~/.bashrc: executed by bash(1) for non-login shells.
# -*- sh -*-
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything

# the PATH export is a workaround to have mosh-server found (resides in
# /usr/local/bin/mosh-server on macOS Homebrew)

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
# Available starting in BASH version 4
shopt -s globstar

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

# bash-completion will automatically source file ~/.bash_completion
# Ubuntu : sudo apt install bash-completion
# macOS: brew install bash-completion@2 (BASH 4.1+)
# the following only needed under macOS/Homebrew
if [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] ; then
    # # If you'd like to use existing homebrew v1 completions, add the following before
    # export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
    source "/usr/local/etc/profile.d/bash_completion.sh"
fi

if [ -f $HOME/projects/vcpkg/scripts/vcpkg_completion.bash ] ; then
    source $HOME/projects/vcpkg/scripts/vcpkg_completion.bash
fi

# # some Mac OS X specific checks
# if [  "$(uname -s)" == 'Darwin' ]
# then
#     ### http://brettterpstra.com/2014/05/10/bash-and-dash/

#     # Open argument in Dash
#     function dash() {
#         open "dash://$*"
#     }

#     function dman() {
#         open "dash://man:$*"
#     }

#     # http://hints.macworld.com/article.php?story=20131226153018801
#     # function man { if [ $# -eq 1 ] ; then open x-man-page://$1 ; elif [ $# -eq 2 ] ; then open x-man-page://$1/$2 ; fi }


# fi

# nvm - node version manager
if [ "$(uname -s)" == 'Darwin' ] ; then
    # brew info nvm
    if [ -z $NVM_DIR ] ; then
        # mkdir -p ~/.nvm
        export NVM_DIR="$HOME/.nvm"
    fi
    # to use in non-interactive shell, must source independently
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
else
    export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"

    # duplication of "auto-added by nvm" stuff
    # Changed with v0.37 nvm # export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
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
# pip3 install --user powerline-shell
function _update_ps1() {
    PS1=$(powerline-shell $?)
}

# need to look for particular TERM before setting, otherwise Emacs TRAMP to linux hangs
case "$TERM" in
    xterm-color|*-256color|xterm-kitty)
        if builtin type -P powerline-shell &>/dev/null ; then
            PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
        fi
        ;;
esac

export PS2='> '    # Secondary prompt
export PS3='#? '   # Prompt 3
export PS4='+'     # Prompt 4

# Have to do iTerm2 shell integration after powerline-shell as it messes with
# prompt

# only source if we are a smarter shell (and on macOS, for now)
if [ "$(uname -s)" == 'Darwin' ]
then
    # # https://www.iterm2.com/documentation-tmux-integration.html
    # export ITERM_ENABLE_SHELL_INTEGRATION_WITH_TMUX=1

    # handles xterm-256color tmux-256color
    # shellcheck source=/dev/null
    [[ "$TERM" == *-256color ]] && test -e "${shell_config}/.iterm2_shell_integration.bash" && source "${shell_config}/.iterm2_shell_integration.bash"
fi

# Secure shellfish (iOS app) integration
test -e "$HOME/.shellfishrc" && source "$HOME/.shellfishrc"

# Alias definitions. ----------------------------------------------

# See /usr/share/doc/bash-doc/examples in the bash-doc package.
if [ -f ~/.bash_aliases ]; then
    # shellcheck source=.bash_aliases
    source ~/.bash_aliases

    if  [ -f "${shell_config}"/local.aliases.sh ]; then
        # shellcheck source=.config/shell/local.aliases.sh
        source "${shell_config}"/local.aliases.sh
    fi
fi

# source bash aliases with secrets
if [ -f ~/.bash_aliases.op-secrets.sh ]; then
    # will contain an alias like opeval="eval \$(op signin <signinaddress> <emailaddress> <secretkey>)"
    # shellcheck source=/dev/null
    source ~/.bash_aliases.op-secrets.sh
fi

# Editors ----------------------------------------------------------

case $OSTYPE in
    darwin*)
        EMACSPATH=/Applications/Emacs.app/Contents/MacOS
        EMACSPATH_BIN="${EMACSPATH}/bin"
        if [[ ! -d "${EMACSPATH_BIN}" ]] ; then
            if [[ -d "${EMACSPATH}/bin-x86_64-10_14" ]] ; then
                EMACSPATH_BIN="${EMACSPATH}/bin-x86_64-10_14"
            fi
        fi
        export EMACSCLIENT="${EMACSPATH_BIN}"/emacsclient
        alias emacsclient=$EMACSCLIENT
        ;;
    *)
        export EMACSCLIENT=emacsclient
        ;;
esac


# Create new frame in windowing env
if command -v vim &>/dev/null ; then
    export EDITOR='emacsclient -a vim --create-frame'
else
    export EDITOR='emacsclient -a vi --create-frame'
fi
export VISUAL=$EDITOR

# set up python for interactive
if [ -f "$HOME"/.pystartup ]; then
    export PYTHONSTARTUP=$HOME/.pystartup
fi

# source local configurations if found
if [[ -r "$shell_config/local.sh" ]]; then
    # shellcheck disable=1090
    source "$shell_config/local.sh"
fi

# per host environment variables
nodename=$(uname -n)
if [[ -f "${shell_config}"/env.$nodename.sh ]] ; then
    # shellcheck source=/dev/null
    source "${shell_config}"/env.$nodename.sh
fi

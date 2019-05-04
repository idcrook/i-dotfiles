# -*- bash -*-
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

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
    modpathargs=${@+"$@"};
    # shellcheck source=/dev/null
    source "${shell_config}/modpath.sh";
    unset modpathargs
}

modpath -q -b /usr/bin        /usr/local/bin
modpath -q -b /usr/local/bin  /usr/local/sbin
modpath -q -b /usr/local/bin  "$HOME"/bin

# pip --user puts stuff in here; add to path before sourcing .bashrc
modpath -q -b "$HOME"/bin     "$HOME"/.local/bin


# the default umask is set in /etc/login.defs
#umask 022

# PATH config
if [ -f ${shell_config}/path.bash.inc ] ; then
    # shellcheck source=/dev/null
    source "${shell_config}"/path.bash.inc
fi


# Load in .bashrc -------------------------------------------------
# shellcheck source=/dev/null
source ~/.bashrc

# Notes: ----------------------------------------------------------
# When you start an interactive shell (log in, open terminal or iTerm in OS X,
# or create a new tab in iTerm) the following files are read and run, in this order:
#     profile
#     bashrc
#     .bash_profile
#     .bashrc (only because this file is run (sourced) in .bash_profile)
#
# When an interactive shell, that is not a login shell, is started
# (when you run "bash" from inside a shell, or when you start a shell in
# xwindows [xterm/gnome-terminal/etc] ) the following files are read and executed,
# ~/.bash_profile: executed by bash(1) for login shells.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

if [ "$PS1" = "" ]     # is shell interactive?
then
	interactive=0
else
	interactive=1
fi


if [ $interactive -eq 1 ]
then
    true
fi



# Set platform-specific enVARIABLES, PATHs
if [  "$(uname -s)" == 'Darwin' ]
then
    if [ -f ~/bin/macos/homebrew/HOMEBREW_GITHUB_API_TOKEN ] ; then
        HOMEBREW_GITHUB_API_TOKEN="$(cat ~/bin/macos/homebrew/HOMEBREW_GITHUB_API_TOKEN)"
        export HOMEBREW_GITHUB_API_TOKEN
    fi

    # https://github.com/Homebrew/brew/pull/5472
    export HOMEBREW_INSTALL_CLEANUP=1
    # export HOMEBREW_NO_INSTALL_CLEANUP=1

    # http://www.funtoo.org/Keychain
    # brew install keychain -> /usr/local/bin/keychain
    # NOTE: The --inherit any option causes keychain to inherit any
    #     ssh key passphrases stored in your Apple MacOS Keychain. If
    #     you would prefer for this to not happen, then this option
    #     can be omitted.
    eval "$(keychain --eval --agents ssh --inherit any id_rsa)"

    # from homebrew - brew info rbenv
    if [ x`which rbenv` == x/usr/local/bin/rbenv ] ; then
        export RBENV_ROOT=/usr/local/var/rbenv
        # DO NOT DO! breaks rbenv - export GEM_PATH="$(brew --prefix)/opt/gems"
        if  command -v rbenv 1>/dev/null 2>&1; then
            eval "$(rbenv init -)";
        fi
        # rbenv versions
        # rbenv install --list
        # gem env home
    fi

    # from homebrew - brew info pyenv
    # https://github.com/pyenv/pyenv#basic-github-checkout
    if [ x`which pyenv` == x/usr/local/bin/pyenv ] ; then
	    export PYENV_ROOT=/usr/local/var/pyenv
	    if command -v pyenv 1>/dev/null 2>&1; then
            eval "$(pyenv init -)"
        fi
    fi

    if [ -d  ~/bin/macos ] ; then
        modpath "${HOME}"/bin/macos
    fi

    ## swiftlang ############################################################

    # https://github.com/kylef/swiftenv/#via-homebrew
    # brew info kylef/formulae/swiftenv
    if [  "$(uname -s)" == 'Darwin' ]
    then
        export SWIFTENV_ROOT=/usr/local/var/swiftenv
	    if command -v swiftenv 1>/dev/null 2>&1; then
            eval "$(swiftenv init -)"
        fi
    fi

    # golang - Homebrew
    if [ -d /usr/local/opt/go/libexec/bin ] ; then
        modpath /usr/local/opt/go/libexec/bin
    fi

    # # https://golang.org/doc/code.html#GOPATH
    # mkdir -p $GOPATH/src/github.com/idcrook
    if [ -d  $HOME/.user_go ] ; then
        export GOPATH=$HOME/.user_go
        modpath $HOME/.user_go/bin
    fi

fi

if [  "$(uname -s)" == 'Linux' ]
then

    # http://www.funtoo.org/Keychain
    # sudo apt install keychain
    if [ -x /usr/bin/keychain ]; then
        keychainpath=/usr/bin/keychain
        eval "$($keychainpath --eval --agents ssh --inherit any id_rsa)"
        unset keychainpath
    fi

    if [ -d  ~/.pyenv/bin ] ; then
        modpath $HOME/.pyenv/bin
	    eval "$(pyenv init -)"
	    eval "$(pyenv virtualenv-init -)"
    fi

    if [ -d ~/bin/linux ] ; then
        modpath "${HOME}"/bin/linux
    fi

    # ubuntu 16.04?
    if [ -d /usr/lib/go-1.9/bin ] ; then
        modpath /usr/lib/go-1.9/bin
    fi

fi

# MSYS2
if [[  "$(uname -s)" == MINGW* ]]
then

    # manually installed from # http://www.funtoo.org/Keychain
    if [ -x ~/bin/windows/msys2/keychain ]; then
        keychainpath=~/bin/windows/msys2/keychain
        eval "$($keychainpath --eval --agents ssh id_rsa)"
        unset keychainpath
    fi

    # if [ -d  ~/.pyenv/bin ] ; then
    #     modpath $HOME/.pyenv/bin
	#     eval "$(pyenv init -)"
	#     eval "$(pyenv virtualenv-init -)"
    # fi

    if [ -d  ~/bin/windows/msys2 ] ; then
        modpath $HOME/bin/windows/msys2
    fi
fi

# perl local modules
# https://metacpan.org/pod/local::lib
if [ -d $HOME/perl5/lib/perl5 ] ; then
    # sets PERL5LIB and others
    eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib)"
    # should warn that it is already in PATH
    modpath $HOME/perl5/bin
fi

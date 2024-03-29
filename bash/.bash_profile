# -*- bash -*-
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# XDG and systemd
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
# https://www.freedesktop.org/wiki/Software/xdg-user-dirs/
# https://www.freedesktop.org/software/systemd/man/file-hierarchy.html

## $XDG_CONFIG_HOME: $HOME/.config
if [[ ! -x "$XDG_CONFIG_HOME" ]]; then
    shell_config="$HOME/.config/shell"
else
    shell_config="$XDG_CONFIG_HOME/shell"
fi

if [[ ! -x "$shell_config" ]]; then
    mkdir -p "$shell_config"
fi

## XDG_DATA_HOME: $HOME/.local/share
if [[ ! -x "$XDG_DATA_HOME" ]]; then
    shell_data="$HOME/.local/share/shell"
else
    shell_data="$XDG_DATA_HOME/shell"
fi

if [[ ! -x "$shell_data" ]]; then
    mkdir -p "$shell_data"
fi

# Path ------------------------------------------------------------

# https://superuser.com/a/753948
pathappend() {
  for ARG in "$@"
  do
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
        PATH="${PATH:+"$PATH:"}$ARG"
    fi
  done
}

pathprepend() {
  for ((i=$#; i>0; i--));
  do
    ARG=${!i}
    if [ -d "$ARG" ] && [[ ":$PATH:" != *":$ARG:"* ]]; then
        PATH="$ARG${PATH:+":$PATH"}"
    fi
  done
}


pathprepend /usr/local/bin /usr/local/sbin "$HOME"/bin "$HOME"/.local/bin

# pip --user puts stuff in here; add to path before sourcing .bashrc
# echo $(systemd-path user-binaries)
pathprepend "$HOME"/.local/bin


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

function is_bin_in_path {
  builtin type -P "$1" &> /dev/null
}

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
    is_bin_in_path keychain && eval "$(keychain --eval --agents ssh --inherit any id_rsa)"

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
        pathappend "${HOME}"/bin/macos
    fi

    ## swiftlang ############################################################

    # https://github.com/kylef/swiftenv/#via-homebrew
    # brew info kylef/formulae/swiftenv
    export SWIFTENV_ROOT=/usr/local/var/swiftenv
	if command -v swiftenv 1>/dev/null 2>&1; then
        eval "$(swiftenv init -)"
    fi

    # python3 - Homebrew
    if [ -d /usr/local/opt/python/libexec/bin ] ; then
        pathprepend /usr/local/opt/python/libexec/bin
    fi

    # golang - Homebrew
    if [ -d /usr/local/opt/go/libexec/bin ] ; then
        pathappend /usr/local/opt/go/libexec/bin
    fi

    # https://github.com/Homebrew/homebrew-command-not-found#install
    # brew tap homebrew/command-not-found
    if brew command command-not-found-init > /dev/null 2>&1; then eval "$(brew command-not-found-init)"; fi


fi

if [  "$(uname -s)" == 'Linux' ]
then

    # http://www.funtoo.org/Keychain
    # sudo apt install keychain
    # if [ -x /usr/bin/keychain ]; then
    #     #echo all="$@" 0=$0 1=$1 BS=${BASH_SOURCE[0]} DS=${DESKTOP_SESSION} >> /tmp/dbg-gdm3-startup
    #     #echo GTS="$GNOME_TERMINAL_SERVICE" GSD=$GNOME_SETUP_DISPLAY GTSS=$GNOME_TERMINAL_SCREEN >>  /tmp/dbg-gdm3-startup
    #     keychainpath=/usr/bin/keychain

    #     noask="--noask"
    #     kcaargs=""
    #     kcaargs="${noask} "
    #     # FIXME: TBD do not prompt if part of Xsession
    #     # if [[ "$0" == *"session" ]] ; then
    #     #     kcaargs="${noask} "
    #     # fi
    #     case "$(uname -r)" in
    #         *-microsoft-*)
    #             eval "$($keychainpath --eval --agents ssh --ignore-missing $kcaargs --inherit any-once id_rsa id_ed25519)"
    #             ;;
    #         * )
    #             eval "$($keychainpath --eval --agents ssh --ignore-missing $kcaargs --inherit any-once id_rsa id_ed25519)"
    #             ;;
    #     esac
    #     unset keychainpath noask kcaargs
    # fi

    # https://github.com/pyenv/pyenv
    # git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    if [ -d  ~/.pyenv/bin ] ; then
        pathappend $HOME/.pyenv/bin
	    eval "$(pyenv init -)"
        # https://github.com/pyenv/pyenv-virtualenv
        # git clone https://github.com/pyenv/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv
	    eval "$(pyenv virtualenv-init -)"
        # git clone https://github.com/pyenv/pyenv-virtualenvwrapper.git ~/.pyenv/plugins/pyenv-virtualenvwrapper
    fi

    if [ -d ~/bin/linux ] ; then
        pathappend "${HOME}"/bin/linux
    fi

    # ubuntu - sudo apt install golang-go
    # ubuntu 18.04 - prefer v1.10
    if [ -d /usr/lib/go-1.10/bin ] ; then
        pathappend /usr/lib/go-1.10/bin
    elif [ -d /usr/lib/go/bin ] ; then
        pathappend /usr/lib/go/bin
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
    #     pathappend $HOME/.pyenv/bin
	#     eval "$(pyenv init -)"
	#     eval "$(pyenv virtualenv-init -)"
    # fi

    if [ -d  ~/bin/windows/msys2 ] ; then
        pathappend $HOME/bin/windows/msys2
    fi
fi

# https://github.com/golang/go/wiki/SettingGOPATH - https://golang.org/doc/code.html#GOPATH
# mkdir -p ~/go/src/github.com
# mkdir -p ~/go/bin
if ! command -v go &> /dev/null
then
    if [[ -d /usr/lib/go-1.15/bin ]] ; then
        pathappend /usr/lib/go-1.15/bin
        export GOPATH=$(go env GOPATH)
        pathappend $(go env GOPATH)/bin
    elif [[ -d /usr/local/go/bin ]] ; then
        pathappend /usr/local/go/bin
        export GOPATH=$(go env GOPATH)
        pathappend $(go env GOPATH)/bin
    else
        echo WARNING: Cannot find golang go
    fi
else
    if [[ -d $(go env GOPATH) ]] ; then
        # export GOPATH=$HOME/go
        export GOPATH=$(go env GOPATH)
        pathappend $(go env GOPATH)/bin
    fi
fi

# perl local modules
# https://metacpan.org/pod/local::lib
if [ -d $HOME/perl5/lib/perl5 ] ; then
    # sets PERL5LIB and local::lib related
    eval "$(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib=$HOME/perl5)"
    # above eval command should already place in PATH
    pathappend $HOME/perl5/bin
fi

# placed here by rustup
#export PATH="$HOME/.cargo/bin:$PATH"
pathappend $HOME/.cargo/bin

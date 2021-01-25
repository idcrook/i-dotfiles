# -*- mode: sh; eval: (sh-set-shell "zsh") -*-

# sourced by zshenv


# add Linux and msys2 support as necessary

# add snap packages before use (golang, hub, ...)
if [[ "$OSTYPE" == linux* ]]
then
    if [[ -d /snap/bin ]] ; then
       path+=/snap/bin
    fi

    # FIXME: make more zsh-ish
    if [ -d ~/bin/linux/containers ] ; then
        for d in $(cd ~/bin/linux/containers && ls -1d 2> /dev/null ) ; do
            if [[ $d == "." ]] ; then continue ; fi ;
            path+=$HOME/bin/linux/containers/${d}
        done
    fi
fi

# macOS python user libraries can be installed here
# See ~/.zshenv for others

# macOS
if [[ "$OSTYPE" == darwin* ]]; then

    # Google Cloud SDK on macOS
    # brew info google-cloud-sdk
    if [ -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ] ; then
        if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc ] ; then
	        source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
        fi
    fi

    if [ -d  "${HOME}"/bin/macos ] ; then
        path+="${HOME}"/bin/macos
    fi

    # pip3 --user uses this dir
    if [[ -d "${HOME}"/Library/Python/3.9/bin ]] ; then
        path=(${HOME}/Library/Python/3.9/bin $path)
    elif [[ -d "${HOME}"/Library/Python/3.8/bin ]] ; then
        path=(${HOME}/Library/Python/3.8/bin $path)
    elif [[ -d "${HOME}"/Library/Python/3.7/bin ]] ; then
        path=(${HOME}/Library/Python/3.7/bin $path)
    fi

    # python@3 - Homebrew
    if [   -d /usr/local/opt/python@3.9/bin ] ; then
        path+=/usr/local/opt/python@3.9/bin
    elif [ -d /usr/local/opt/python@3.8/bin ] ; then
        path+=/usr/local/opt/python@3.8/bin
    fi

    # python3 - Homebrew
    if [   -d /usr/local/opt/python/libexec/bin ] ; then
        path=(/usr/local/opt/python/libexec/bin $path)
    fi

    # on macOS, homebrew version
    if [   -d /usr/local/opt/curl/bin ] ; then
        path=(/usr/local/opt/curl/bin $path)
    fi

    # golang - Homebrew
    if [   -d /usr/local/opt/go/libexec/bin ] ; then
        path+=/usr/local/opt/go/libexec/bin
    fi

    # rbenv - Homebrew
    # handled in zprezto ruby pmodule
fi

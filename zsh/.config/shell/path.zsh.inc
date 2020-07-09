# -*- mode: sh; eval: (sh-set-shell "zsh") -*-

# sourced by zshenv

# Google Cloud SDK on macOS
# brew info google-cloud-sdk
if [ -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ] ; then
    if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc ] ; then
	    source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
    fi
fi

# FIXME: make more zsh-ish
if [ -d ~/bin/linux/containers ] ; then
    for d in $(cd ~/bin/linux/containers && ls -1d 2> /dev/null ) ; do
        if [[ $d == "." ]] ; then continue ; fi ;
        modpath -q ~/bin/linux/containers/${d}
    done
fi

# macOS python user libraries can be installed here
# See ~/.zshenv for others

# pip3 --user uses this dir
if [[ -d "${HOME}"/Library/Python/3.8/bin ]] ; then
    modpath -q -f -d "${HOME}"/Library/Python/3.8/bin
    modpath -q -b /usr/local/bin "${HOME}"/Library/Python/3.8/bin
fi

# pip3 --user uses this dir
if [[ -d ~/Library/Python/3.7/bin ]] ; then
    modpath -q -f -d ~/Library/Python/3.7/bin
    modpath -q -b /usr/local/bin ~/Library/Python/3.7/bin
fi

# python@3.8 - Homebrew
if [ -d /usr/local/opt/python@3.8/bin ] ; then
    modpath -q -a /usr/local/bin /usr/local/opt/python@3.8/bin
fi


# on macOS, homebrew version
modpath -q /usr/local/opt/curl/bin

#!/bin/echo Error: sourcing -*- sh -*-

# More package or platform specific PATHs

# Google Cloud SDK on macOS
# brew cask info homebrew/cask/google-cloud-sdk
if [ -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ] ; then
    if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc ] ; then
	    source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc
    fi
fi


if [ -d ~/bin/linux/containers ] ; then
    for d in $(cd ~/bin/linux/containers && ls -1d  2> /dev/null ) ; do
        if [[ $d == "." ]] ; then continue ; fi ;
        pathappend "$HOME"/bin/linux/containers/${d}
    done
fi

# macOS python user libraries installed here (priority order)
if [ -d ~/Library/Python/3.10/bin ] ; then
    pathprepend "$HOME"/Library/Python/3.10/bin
elif [ -d ~/Library/Python/3.9/bin ] ; then
    pathprepend "$HOME"/Library/Python/3.9/bin
elif [ -d ~/Library/Python/3.8/bin ] ; then
    pathprepend "$HOME"/Library/Python/3.8/bin
elif [ -d ~/Library/Python/3.7/bin ] ; then
    pathprepend "$HOME"/Library/Python/3.7/bin
fi

# on macOS, homebrew version
pathprepend /usr/local/opt/curl/bin

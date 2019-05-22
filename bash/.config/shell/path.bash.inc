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
    for d in $(cd ~/bin/linux/containers && ls -1d * 2> /dev/null ) ; do
        modpath ~/bin/linux/containers/${d}
    done
fi

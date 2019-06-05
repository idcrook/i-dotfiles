# -*- mode: sh; eval: (sh-set-shell "zsh") -*-



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
if [[ -d ~/Library/Python/3.7/bin ]] ; then
    modpath -q ~/Library/Python/3.7/bin
fi

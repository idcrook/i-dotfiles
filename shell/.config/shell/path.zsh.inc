# -*- mode: sh; eval: (sh-set-shell "zsh") -*-

# sourced by zshenv


# add Linux and msys2 support as necessary

# add snap packages before use (golang, hub, ...)
if [[ "$OSTYPE" == linux* ]]
then
    if [[ -d /snap/bin ]] ; then
       path+=/snap/bin
    fi

    if [ -d ~/bin/linux/containers ] ; then
        for d in $(cd ~/bin/linux/containers && ls -1d 2> /dev/null ) ; do
            if [[ $d == "." ]] ; then continue ; fi ;
            path+=$HOME/bin/linux/containers/${d}
        done
    fi
fi

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

    # NOTE: these directories or paths can be handled by zprezto modules

    # pip3 --user uses this dir
    # macOS python user libraries can be installed here
    # if [[ -d "${HOME}"/Library/Python/3.10/bin ]] ; then
    #     path=(${HOME}/Library/Python/3.10/bin $path)
    # elif [[ -d "${HOME}"/Library/Python/3.9/bin ]] ; then
    #     path=(${HOME}/Library/Python/3.9/bin $path)
    # elif [[ -d "${HOME}"/Library/Python/3.8/bin ]] ; then
    #     path=(${HOME}/Library/Python/3.8/bin $path)
    # elif [[ -d "${HOME}"/Library/Python/3.7/bin ]] ; then
    #     path=(${HOME}/Library/Python/3.7/bin $path)
    # fi

    if [ -x "$(command -v brew)" ]; then

        # python (python3) - Homebrew
        if [   -d $(brew --prefix)/opt/python/libexec/bin ] ; then
            path=( $(brew --prefix)/opt/python/libexec/bin $path)
        fi

        ### [Homebrew/homebrew-command-not-found](https://github.com/Homebrew/homebrew-command-not-found)
        HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
        if [ -f "$HB_CNF_HANDLER" ] ; then
            source "$HB_CNF_HANDLER"
        fi

        # on macOS, homebrew version is keg-only
        if [ -d $(brew --prefix)/opt/curl/bin ] ; then
            path=($(brew --prefix)/opt/curl/bin $path)
        fi

        # # golang - Homebrew
        # if [   -d /usr/local/opt/go/libexec/bin ] ; then
        #     path+=/usr/local/opt/go/libexec/bin
        # fi

        # rbenv - Homebrew
        # handled in zprezto ruby pmodule
    fi
fi

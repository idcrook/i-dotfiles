# -*- sh -*-

# BASH aliases on macOS and Linux
#
# TODO: add graceful checks and fallbacks where applicable

# meta-aliases
alias sal='echo sourcing ~/.bash_aliases ; source ~/.bash_aliases'
alias val='vi ~/.bash_aliases; sal'


if [ "$(uname -s)" == 'Darwin' ]
then
    alias top='top -o cpu'
    alias cons="tail -40 -f /var/log/system.log"
    alias startx="open /Applications/Utilities/X11.app"
    alias emacsclient="/usr/local/bin/emacsclient"
    alias e="emacsclient -c"
    alias ect="emacsclient -t"       # -t : terminal
    # send client to background (do not block)
    eo() { emacsclient -c "$@" & }

    # https://hub.github.com/
    # brew install hub
    if [ -x /usr/local/bin/hub ]
    then
	    alias git=hub
    fi

    # USAGE
    #      ne somefile:line
    # via https://www.reddit.com/r/emacs/comments/9sz0ql/make_emacs_open_files_at_specific_line_numbers_as/
    ne() {
        local args=()
        for arg in "$@" ; do
            # Replace line numbers specified with <FILE>:n into the +n <FILE> emacs syntax
            args+=($(echo $arg | sed -E 's/(.*):([0-9]+)/+\2 \1/'))
        done;
        Emacs26.sh ${args[*]}
    }

    alias fixow='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user;killall Finder;echo "Open With has been rebuilt, Finder will relaunch"'

    alias mo="open -a 'Marked 2'"

    alias filetree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"

    # this loads nvm
    # brew info nvm
    alias nvms='export NVM_DIR="$HOME/.nvm" ; [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"'

else  # not Darwin/macOS

    if [ -x /usr/bin/notify-send ] ; then
        # Add an "alert" alias for long running commands.  Use like so:
        #   sleep 10; alert
        alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
    fi

    alias e="emacsclient -c"

    alias systail='tail -f /var/log/syslog'

    # https://hub.github.com/
    # sudo apt install hub
    if [ -x /usr/bin/hub ]
    then
	    alias git=hub
    fi

    # shellcheck disable=2139
    alias nvms="export NVM_DIR='${HOME}/.nvm' ; [ -s \"\$NVM_DIR/nvm.sh\" ] && \. \"\$NVM_DIR/nvm.sh\""
fi


# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then

    # (Linux)
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls -F --color=auto'
        alias dir='ls  --format=vertical'
        alias vdir='ls --format=long'
    fi

    # (macOS)
    if [ "$(uname -s)"  == 'Darwin' ] ; then
        # gls is GNU coreutils version
        # brew install coreutils
        if command -v gls > /dev/null 2>&1; then
            alias ls='gls -F --color=auto'
        else
            alias ls='ls -F -G'  # macOS - -G in macOS is for colors, in Linux it's no groups
        fi
    fi

    # the command options/utilities seem to be consistent across these platforms
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
    alias lessc="less -R"
fi

# https://stuff-things.net/2019/09/04/updated-emacs-open-with-line-numbers/
function ec () {
    # Replace line numbers specified with <FILE>:n <FILE>:#Ln into the +n <FILE> emacs syntax
    if [[ $1 =~ (.*)[:#]L?([0-9]+)$ ]]; then
        $EMACSCLIENT -c -n "+${BASH_REMATCH[2]}" "${BASH_REMATCH[1]}"
    else
        $EMACSCLIENT -c -n "$@"
    fi
}


# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lla='ls -lah'

# disk usage
alias dus='du -sch * | sort -n'

# Other aliases ----------------------------------------------------

# Misc
alias g='grep -i'  # Case insensitive grep
alias f='find . -iname'
alias ducks='du -cksh * | sort -rn|head -11' # Lists folders and files sizes in the current folder
alias m='more'
alias df='df -h'

alias sshj="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" # don't cache host fingerprints
alias ssh="sshj"

# silver searcher (grep/ack improved)
alias ipa='curl --silent checkip.dyndns.org | ag --only-matching "[0-9.]+"'
alias agf="ag --hidden --files-with-matches --file-search-regex"

# 1Password CLI ------------------------------------------------------------

# op command wrapper to set account argument
opm (){
	command op "$@" --account=my
}

# show password
# usage: opp Dropbox
# requires jq
opp (){
    opm get item "$1" | jq -r '.details.fields[] | select(.designation=="password").value'
}

optp (){
    uuid="$(opm get item $1 | jq -r '.uuid')"
    opm get totp "${uuid}"
}


# Navigation -------------------------------------------------------
alias o='cd ..'
alias oo='cd ../..'
alias ooo='cd ../../..'
alias oooo='cd ../../../..'
alias vf='cd'  # common typo

alias pu='pushd'
alias po='popd'

# I got the following from, and mod'd it: http://www.macosxhints.com/article.php?story=20020716005123797
#    The following aliases (save & show) are for saving frequently used directories
#    You can save a directory using an abbreviation of your choosing. Eg. save ms
#    You can subsequently move to one of the saved directories by using cd with
#    the abbreviation you chose. Eg. cd ms  (Note that no '$' is necessary.)
if [ ! -f ~/.dirs ]; then  # if doesn't exist, create it
	touch ~/.dirs
fi

alias show='cat ~/.dirs'
save (){
	command sed "/!$/d" ~/.dirs > ~/.dirs1; \mv ~/.dirs1 ~/.dirs; echo "$@"=\"$(pwd)\" >> ~/.dirs; source ~/.dirs ;
}
if [ -f ~/.dirs ] ; then
    # shellcheck source=/dev/null
    source ~/.dirs  # Initialization for the above 'save' facility
else
    touch ~/.dirs
fi

# set the bash option so that no '$' is required when using the above facility
shopt -s cdable_vars

# https://medium.com/@marko.luksa/bash-trick-repeat-last-command-until-success-750a61c43c8a
# rpt: will re-run previous command until it succeeds
rpt() {
  CMD=$(fc -ln | tail -2 | head -1)
  echo "repeating until success: $CMD"
  until $CMD
  do
    sleep 1
  done
}

# Shows most used commands, cool script I got this from: http://lifehacker.com/software/how-to/turbocharge-your-terminal-274317.php
# shellcheck disable=2142
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"

# kubernetes ------------------------------------------------------------------
alias kbk="kubectl"
alias kbn="kubectl  --namespace=kube-system"
# alias kbb="kubectl  --namespace=metallb-system"
# alias kbi="kubectl  --namespace=ingress-nginx"
# alias kbf="kubectl  --namespace=openfaas"
# alias kbfn="kubectl --namespace=openfaas-fn"

# _complete_alias requires https://github.com/cykerway/complete-alias to be loaded
# ~/.bash_completion.d/complete_alias loaded by ~/.bash_completion
complete -F _complete_alias kbk
complete -F _complete_alias kbn
# complete -F _complete_alias kbb
# complete -F _complete_alias kbi
# complete -F _complete_alias kbf
# complete -F _complete_alias kbfn

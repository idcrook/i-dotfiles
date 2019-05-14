# -*- sh -*-

if [ `uname -s` == 'Darwin' ]
then
    alias ls='ls -FG'
    alias top='top -o cpu'
    alias cons="tail -40 -f /var/log/system.log"
    alias dir=ls
    alias startx="open /Applications/Utilities/X11.app"
    alias emacsclient="/usr/local/bin/emacsclient"
    alias e="emacsclient -c"
    # -t : terminal
    alias et="emacsclient -t"
    # send client to background (do not block)
    eo() { emacsclient -c "$@" & }
    if [ -f /usr/local/bin/aws_completer ] ; then
	complete -C aws_completer aws
    fi

    if [ -x /usr/local/bin/hub ] ; then
	alias git=hub
    fi

    # USAGE
    #      ne somefile:line
    # via https://www.reddit.com/r/emacs/comments/9sz0ql/make_emacs_open_files_at_specific_line_numbers_as/
    ne() {
        local args=()
        for arg in "$@" ; do
            # Replace line numbers specified with <FILE>:n into the +n <FILE> emacs syntax
            args+=(`echo $arg | sed -E 's/(.*):([0-9]+)/+\2 \1/'`)
        done;
        Emacs.sh ${args[*]}
    }


    alias fixow='/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister -kill -r -domain local -domain user;killall Finder;echo "Open With has been rebuilt, Finder will relaunch"'

    alias mo="open -a 'Marked 2'"

    # silver surfer
    alias ipa='curl --silent checkip.dyndns.org | ag --only-matching "[0-9.]+"'
    alias agf="ag --hidden --files-with-matches --file-search-regex"
    alias agc="ag --color"

    alias lessc="less -R"
    alias filetree="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/ /' -e 's/-/|/'"

else  # not Darwin/macOS

    if [ -x /usr/bin/notify-send ] ; then
        # Add an "alert" alias for long running commands.  Use like so:
        #   sleep 10; alert
        alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
    fi

    # enable color support of ls and also add handy aliases
    if [ "$TERM" != "dumb" ]; then
	if [ -x /usr/bin/dircolors ] ; then
	    eval "`dircolors -b`"
	fi
	alias ls='ls --color=auto'
	alias dir='ls --color=auto --format=vertical'
	alias vdir='ls --color=auto --format=long'
    fi
    alias e="emacsclient -c"
    alias grep="grep --color=auto"

    alias nvms='export NVM_DIR="/home/dpc/.nvm" ; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"'
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lla='ls -lah'

alias o='cd ..'
alias oo='cd ../..'
alias ooo='cd ../../..'
alias oooo='cd ../../../..'
alias vf='cd'

alias pu='pushd'
alias po='popd'

# disk usage
alias dus='du -sch * | sort -n'

alias sal='echo sourcing ~/.bash_aliases ; source ~/.bash_aliases'
alias val='vi ~/.bash_aliases; sal'

# Other aliases ----------------------------------------------------

# Misc
alias g='grep -i'  # Case insensitive grep
alias f='find . -iname'
alias ducks='du -cksh * | sort -rn|head -11' # Lists folders and files sizes in the current folder
alias systail='tail -f /var/log/syslog'
alias m='more'
alias df='df -h'

alias sshj="ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null"
alias ssh="sshj"

# 1Password

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
    opm get totp ${uuid}
}


# Navigation -------------------------------------------------------
#alias ..='cd ..'
#alias ...='cd .. ; cd ..'

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
	command sed "/!$/d" ~/.dirs > ~/.dirs1; \mv ~/.dirs1 ~/.dirs; echo "$@"=\"`pwd`\" >> ~/.dirs; source ~/.dirs ;
}
source ~/.dirs  # Initialization for the above 'save' facility: source the .sdirs file
shopt -s cdable_vars # set the bash option so that no '$' is required when using the above facility


# Shows most used commands, cool script I got this from: http://lifehacker.com/software/how-to/turbocharge-your-terminal-274317.php
alias profileme="history | awk '{print \$2}' | awk 'BEGIN{FS=\"|\"}{print \$1}' | sort | uniq -c | sort -n | tail -n 20 | sort -nr"


if [  `uname -s` == 'Darwin' ]
then

    alias ls='ls -G'  # OS-X SPECIFIC - the -G command in OS-X is for colors, in Linux it's no groups
fi

# kubernetes
alias kbk="kubectl"
alias kbn="kubectl --namespace=kube-system"
alias kbb="kubectl --namespace=metallb-system"
alias kbi="kubectl --namespace=ingress-nginx"
alias kbf="kubectl --namespace=openfaas"
alias kbfn="kubectl --namespace=openfaas-fn"

# breaks alias expansion # echo command before running
#kubectl () { echo "+ kubectl $@"; command kubectl $@ ; }

# _complete_alias requires https://github.com/cykerway/complete-alias to be loaded
complete -F _complete_alias kbk
complete -F _complete_alias kbn
complete -F _complete_alias kbb
complete -F _complete_alias kbi
complete -F _complete_alias kbf
complete -F _complete_alias kbfn

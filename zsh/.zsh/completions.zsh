# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Defines local completions
#
# Authors:
#   David Crook <david.crook@gmail.com>

# See /usr/local/share/zsh/site-functions for homebrew installs

# see man zshcompsys / compinit
# completions on macOS:
# MAIN:  /usr/local/share/zsh/site-functions

# PUT ANY CUSTOM completions in ~/.zsh/completions.d
# if [[ -d ${ZDOTDIR:-$HOME}/.zsh/completions.d ]] ; then
#   fpath=(${ZDOTDIR:-$HOME}/.zsh/completions.d $fpath)
#   # handled in zprezto package completion # autoload -U compinit
#   # -u skips checks for insecure directory and file
#   #compinit -u
# fi

# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
# automatically handled by zprezto
# if type brew &>/dev/null; then
#   FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
# fi

# hub ------------------------------------------------------------------------

# `brew info hub` - completions go in central Homebrew
# /usr/local/share/zsh/site-functions/_hub

# <https://github.com/github/hub/tree/master/etc#zsh>
# ```
# wget https://github.com/github/hub/raw/master/etc/hub.zsh_completion
# mv hub.zsh_completion _hub
# ```

if [ -x "$(command -v brew)" ]; then
    # curl -----------------------------------------------------------------------

    # curl is keg-only, and its completions do not go into central Homebrew
    # `brew info curl`
    # echo $(brew --prefix)

    if [[ -d $(brew --prefix)/opt/curl/share/zsh/site-functions ]] ; then
        fpath=($(brew --prefix)/opt/curl/share/zsh/site-functions $fpath)
    fi

fi

# kubernetes ------------------------------------------------------------

# OBVIATED by inclusion in Homebrew `kubernetes-cli` package
# `brew list kubernetes-cli`
# /usr/local/share/zsh/site-functions/_kubectl

# adapted from
# https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion
# if (( $+commands[kubectl] )) ; then
#     source <(kubectl completion zsh)
#     alias kbk="kubectl"
#     alias kbn="kbk --namespace=kube-system"
#     complete -F __start_kubectl kbk
# fi

# nvm (node version manager)  -------------------------------------------

# .zprezto has built-in support for nvm via node module, so do not need

# brew info nvm

# [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

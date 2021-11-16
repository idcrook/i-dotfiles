# -*- mode: sh; eval: (sh-set-shell "zsh") -*-
#
# Defines local completions
#
# Authors:
#   David Crook <david.crook@gmail.com>

# See /usr/local/share/zsh/site-functions for homebrew installs

# see man zshcompsys / compinit
# completions on macOS:
# MAIN:     /usr/local/share/zsh/site-functions
# MAIN:  /opt/homebrew/share/zsh/site-functions (Apple Silicon homebrew)

# Use ~/.zsh/completions.d for custom completions
if [[ -d ${HOME}/.zsh/completions.d ]] ; then
  fpath=(${HOME}/.zsh/completions.d $fpath)
fi

# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
# automatically handled by zprezto
# if type brew &>/dev/null; then
#   FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
# fi


if [ -x "$(command -v brew)" ]; then
    # curl -------------------------------------------------------------------

    # curl is keg-only, and its completions do not go into central Homebrew
    # `brew info curl`
    # echo $(brew --prefix)

    if [[ -d   $(brew --prefix)/opt/curl/share/zsh/site-functions ]] ; then
        fpath=($(brew --prefix)/opt/curl/share/zsh/site-functions $fpath)
    fi

    # Homebrew ---------------------------------------------------------------

    # homebrew shared zsh completions
    if [[ -d   $(brew --prefix)/share/zsh/site-functions ]] ; then
        fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
    fi

    # zsh-completions --------------------------------------------------------

    # brew info zsh-completions

    # zprezto adds local version to fpath in modules/completion/init.zsh
    #                         definitions in modules/completion/external/src
    # adding homebrew version here should be OK?
    if [[ -d   $(brew --prefix)/share/zsh-completions ]] ; then
        fpath=($(brew --prefix)/share/zsh-completions $fpath)
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

# -*- mode: sh; eval: (sh-set-shell "zsh") -*-

# Defines local aliases
#
# Authors:
#   David Crook <david.crook@gmail.com>


# kubernetes ------------------------------------------------------------
# adapted from https://kubernetes.io/docs/tasks/tools/install-kubectl/#enabling-shell-autocompletion
if (( $+commands[kubectl] )) ; then
    source <(kubectl completion zsh)
    alias kbk="kubectl"
    alias kbn="kbk --namespace=kube-system"
    complete -F __start_kubectl kbk
fi

# -*- sh -*-
#
# per-host environment variable settings
#
# - `hostname` in filename should be replaced by hostname (`uname -n` nodename)
# - should be sourceable by both bash or zsh
#
# INSTALL AFTER CREATION
#
# cd ~/.dotfiles
# stow -vv shell
#
# EXAMPLE
#
# to use the shared openscad-mcad in openscad-nightly on ubuntu, need to update
# an environment variable
if [ -d /usr/share/openscad/libraries ] ; then
    export OPENSCADPATH=/usr/share/openscad/libraries:"${OPENSCADPATH}"
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/dpc/projects/ai/miniconda/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/dpc/projects/ai/miniconda/etc/profile.d/conda.sh" ]; then
        . "/Users/dpc/projects/ai/miniconda/etc/profile.d/conda.sh"
    else
        export PATH="/Users/dpc/projects/ai/miniconda/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Local Variables:
# mode: sh
# eval: (sh-set-shell "bash")
# End:

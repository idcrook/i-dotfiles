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
# # to use the shared openscad-mcad in openscad-nightly on ubuntu, need to update
# # an environment variable
# if [ -d /usr/share/openscad/libraries ] ; then
#     export OPENSCADPATH=/usr/share/openscad/libraries:"${OPENSCADPATH}"
# fi

# >>> conda initialize >>>
__conda_setup="$('/home/dpc/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/dpc/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/dpc/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/dpc/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# https://docs.microsoft.com/en-us/windows/ai/directml/gpu-faq#how-do-i-use-the--dml-visible-devices--environment-variable-to-control-which-gpu-s--get-used-by-directml
export DML_VISIBLE_DEVICES="0"

# Local Variables:
# mode: sh
# eval: (sh-set-shell "bash")
# End:

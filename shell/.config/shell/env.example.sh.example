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

# Local Variables:
# mode: sh
# eval: (sh-set-shell "bash")
# End:

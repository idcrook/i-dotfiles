# -*- sh -*-
# per-host environment variable settings
#
# - `hostname` in filename should be replaced by hostname (`uname -n` nodename)
# - should be sourcable by bash or zsh
#
# INSTALL AFTER CREATION
#
# cd ~/.dotfiles
# stow -vv shell
#
# EXAMPLE
#
# to use openscad-mcad in openscad-nightly on ubuntu, need to set environment
# variable
#
if [ -d /usr/share/openscad/libraries ] ; then
    export OPENSCADPATH=/usr/share/openscad/libraries
fi

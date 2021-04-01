# -*- sh -*-
#
# per-OS environment variable settings
#
# - should be sourceable by bash or zsh
#
# INSTALL AFTER CREATION
#
# cd ~/.dotfiles
# stow -vv shell
#

# Raspberry Pi Pico SDK
# - https://github.com/raspberrypi/pico-sdk
# - https://datasheets.raspberrypi.org/pico/getting-started-with-pico.pdf
# - https://raw.githubusercontent.com/raspberrypi/pico-setup/master/pico_setup.sh
if [[ -d "${HOME}"/projects/pico/pico-sdk ]] ; then
    export PICO_SDK_PATH="${HOME}"/projects/pico/pico-sdk
elif [[ -d "${HOME}"/pico/pico-sdk ]] ; then
    export PICO_SDK_PATH="${HOME}"/pico/pico-sdk
fi


# Local Variables:
# mode: sh
# eval: (sh-set-shell "bash")
# End:

# -*- sh -*-
#
# Environment variable settings
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
# export PICO_SDK_PATH=/home/pi/projects/pico/pico-sdk
# export PICO_EXAMPLES_PATH=/home/pi/projects/pico/pico-examples
# export PICO_EXTRAS_PATH=/home/pi/projects/pico/pico-extras
# export PICO_PLAYGROUND_PATH=/home/pi/projects/pico/pico-playground
if [[ -d "${HOME}"/projects/pico/pico-sdk ]] ; then
    export PICO_SDK_PATH="${HOME}"/projects/pico/pico-sdk
elif [[ -d "${HOME}"/pico/pico-sdk ]] ; then
    export PICO_SDK_PATH="${HOME}"/pico/pico-sdk
fi

if [[ -d "${HOME}"/projects/pico/pico-examples ]] ; then
    export PICO_EXAMPLES_PATH="${HOME}"/projects/pico/pico-examples
elif [[ -d "${HOME}"/pico/pico-examples ]] ; then
    export PICO_EXAMPLES_PATH="${HOME}"/pico/pico-examples
fi

if [[ -d "${HOME}"/projects/pico/pico-extras ]] ; then
    export PICO_EXTRAS_PATH="${HOME}"/projects/pico/pico-extras
elif [[ -d "${HOME}"/pico/pico-extras ]] ; then
    export PICO_EXTRAS_PATH="${HOME}"/pico/pico-extras
fi

if [[ -d "${HOME}"/projects/pico/pico-playground ]] ; then
    export PICO_PLAYGROUND_PATH="${HOME}"/projects/pico/pico-playground
elif [[ -d "${HOME}"/pico/pico-playground ]] ; then
    export PICO_PLAYGROUND_PATH="${HOME}"/pico/pico-playground
fi


# Local Variables:
# mode: sh
# eval: (sh-set-shell "bash")
# End:

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

# https://rye-up.com/guide/installation/
rye_env="$HOME/.rye/env"
if [ -f "${rye_env}" ] ; then
    source "${rye_env}"
fi
unset rye_env

# Raspberry Pi Pico SDK
# - https://github.com/raspberrypi/pico-sdk
# - https://datasheets.raspberrypi.org/pico/getting-started-with-pico.pdf
# - https://raw.githubusercontent.com/raspberrypi/pico-setup/master/pico_setup.sh
# export PICO_SDK_PATH=/home/pi/pico/pico-sdk
# export PICO_EXAMPLES_PATH=/home/pi/pico/pico-examples
# export PICO_EXTRAS_PATH=/home/pi/pico/pico-extras
# export PICO_PLAYGROUND_PATH=/home/pi/pico/pico-playground
if [[ -d "${HOME}"/pico/pico-sdk ]] ; then
    export PICO_SDK_PATH="${HOME}"/pico/pico-sdk
elif [[ -d "${HOME}"/pico/pico-sdk ]] ; then
    export PICO_SDK_PATH="${HOME}"/pico/pico-sdk
fi

if [[ -d "${HOME}"/pico/pico-examples ]] ; then
    export PICO_EXAMPLES_PATH="${HOME}"/pico/pico-examples
elif [[ -d "${HOME}"/pico/pico-examples ]] ; then
    export PICO_EXAMPLES_PATH="${HOME}"/pico/pico-examples
fi

if [[ -d "${HOME}"/pico/pico-extras ]] ; then
    export PICO_EXTRAS_PATH="${HOME}"/pico/pico-extras
elif [[ -d "${HOME}"/pico/pico-extras ]] ; then
    export PICO_EXTRAS_PATH="${HOME}"/pico/pico-extras
fi

if [[ -d "${HOME}"/pico/pico-playground ]] ; then
    export PICO_PLAYGROUND_PATH="${HOME}"/pico/pico-playground
elif [[ -d "${HOME}"/pico/pico-playground ]] ; then
    export PICO_PLAYGROUND_PATH="${HOME}"/pico/pico-playground
fi


# Local Variables:
# mode: sh
# eval: (sh-set-shell "bash")
# End:

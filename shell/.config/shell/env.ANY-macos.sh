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

macos_pico_dir="${HOME}"/projects/hw
macos_pico_dir2="${HOME}"/projects/rpi

if [[ -d "${macos_pico_dir}"/pico-sdk ]] ; then
    export PICO_SDK_PATH="${macos_pico_dir}"/pico-sdk
elif [[ -d "${macos_pico_dir2}"/pico-sdk  ]] ; then
    export PICO_SDK_PATH="${macos_pico_dir2}"/pico/pico-sdk
fi

if [[ -d "${macos_pico_dir}"/pico-examples ]] ; then
    export PICO_EXAMPLES_PATH="${macos_pico_dir}"/pico-examples
elif [[ -d "${macos_pico_dir2}"/pico-examples  ]] ; then
    export PICO_EXAMPLES_PATH="${macos_pico_dir2}"/pico/pico-examples
fi

if [[ -d "${macos_pico_dir}"/pico-extras ]] ; then
    export PICO_EXTRAS_PATH="${macos_pico_dir}"/pico-extras
elif [[ -d "${macos_pico_dir2}"/pico-extras  ]] ; then
    export PICO_EXTRAS_PATH="${macos_pico_dir2}"/pico/pico-extras
fi

if [[ -d "${macos_pico_dir}"/pico-playground ]] ; then
    export PICO_PLAYGROUND_PATH="${macos_pico_dir}"/pico-playground
elif [[ -d "${macos_pico_dir2}"/pico-playground  ]] ; then
    export PICO_PLAYGROUND_PATH="${macos_pico_dir2}"/pico/pico-playground
fi

unset macos_pico_dir
unset macos_pico_dir2


# Local Variables:
# mode: sh
# eval: (sh-set-shell "bash")
# End:

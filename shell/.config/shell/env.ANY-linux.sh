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

# esp8266 rtos SDK
if [[ -d "${HOME}"/projects/hw/esp/xtensa-lx106-elf/bin ]] ; then
    export PATH="$PATH:$HOME/projects/hw/esp/xtensa-lx106-elf/bin"
fi

# Local Variables:
# mode: sh
# eval: (sh-set-shell "bash")
# End:


# Local Variables:
# mode: sh
# eval: (sh-set-shell "bash")
# End:

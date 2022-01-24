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

# IDF_PATH = Espressif SDK

# # ESP-IDF - FIXME: create an alias for switching to ESP32
# if [[ -d "${HOME}/projects/hw/esp/esp-idf" ]] ; then
#     export IDF_PATH="${HOME}/projects/hw/esp/esp-idf"
# fi

# ESP8266_RTOS_SDK
if [[ -d "${HOME}/projects/hw/esp/ESP8266_RTOS_SDK" ]] ; then
    export IDF_PATH="${HOME}/projects/hw/esp/ESP8266_RTOS_SDK"
fi

# CUDA https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html#post-installation-actions
if [[ -d "/usr/local/cuda-11.6/bin" ]] ; then
    export PATH="/usr/local/cuda-11.6/bin${PATH:+:${PATH}}"

    export LD_LIBRARY_PATH=/usr/local/cuda-11.6/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
fi


# Local Variables:
# mode: sh
# eval: (sh-set-shell "bash")
# End:

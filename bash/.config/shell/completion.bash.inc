#!/bin/echo Error: sourcing -*- sh -*-

# BASH completions config

# Ubuntu : sudo apt install bash-completion
# macOS : brew install bash-completion@2

# # enable programmable completion features (you don't need to enable
# # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# # sources /etc/bash.bashrc).
# if ! shopt -oq posix; then
#     if [ -f /usr/share/bash-completion/bash_completion ]; then
#         # shellcheck source=/dev/null
#         source /usr/share/bash-completion/bash_completion
#     elif [ -f /etc/bash_completion ]; then
#         # shellcheck source=/dev/null
#         source /etc/bash_completion
#     fi
# fi

# kubectl bash completions
if hash kubectl 2>/dev/null; then
    # shellcheck source=/dev/null
    source <(kubectl completion bash)
fi

# via https://github.com/cykerway/complete-alias
# requires BASH 4
# mkdir ~/.bash_completion.d
# curl -o bash_complete-alias.sh  https://raw.githubusercontent.com/cykerway/complete-alias/master/bash_completion.sh
# mv bash_complete-alias.sh  ~/.bash_completion.d
if [ -f ~/.bash_completion.d/bash_complete-alias.sh ] ; then
    # shellcheck source=.bash_completion.d/bash_complete-alias.sh
    source ~/.bash_completion.d/bash_complete-alias.sh
fi


# docker completion on macOS (once per machine) - with Homebrew bash completion installed
####  https://docs.docker.com/docker-for-mac/#bash
# etc=/Applications/Docker.app/Contents/Resources/etc
# ln -s $etc/docker.bash-completion $(brew --prefix)/etc/bash_completion.d/docker
# ln -s $etc/docker-machine.bash-completion $(brew --prefix)/etc/bash_completion.d/docker-machine
# ln -s $etc/docker-compose.bash-completion $(brew --prefix)/etc/bash_completion.d/docker-compose


# # http://beets.readthedocs.io/en/v1.4.7/reference/cli.html#shell-completion
# # if hash beet 2>/dev/null; then
# #     eval "$(beet completion)"
# # fi
# # to save time:
# #     beet completion > .bash_completion.d/beet-completion.sh
# if [ -f ~/.bash_completion.d/beet-completion.sh ] ; then
#     # shellcheck source=.bash_completion.d/beet-completion.sh
#     source ~/.bash_completion.d/beet-completion.sh
# fi


# Google Cloud SDK on macOS
# brew cask info homebrew/cask/google-cloud-sdk
if [ -d /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk ] ; then
    if [ -f /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc ] ; then
        source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc
    fi
fi

# # brew install bash-completion (BASH 3)
# if [ -f "$(brew --prefix)"/etc/bash_completion ]; then
#     # shellcheck source=/dev/null
#     source "$(brew --prefix)"/etc/bash_completion
# fi

# brew install bash-completion@2 (BASH 4.1+)
if [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] ; then
    # # If you'd like to use existing homebrew v1 completions, add the following before
    # export BASH_COMPLETION_COMPAT_DIR="/usr/local/etc/bash_completion.d"
    source "/usr/local/etc/profile.d/bash_completion.sh"
fi
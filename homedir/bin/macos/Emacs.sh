#!/bin/bash
#!/bin/bash -x

# Adapted from https://stackoverflow.com/a/38276432
#
# for Homebrew
# - d12frosted/emacs-plus
# - cask emacs
#
# EMACSPATH : .../Emacs.app/Contents/MacOS
# EMACSPATH_BIN : Location (directory) of binaries like emacsclient
# EMACS_WRAPPER_OR_BIN : Actual Emacs.app macOS binary

# open --new -a /Applications/Emacs.app --args --debug-init
# open -n -a /opt/homebrew/opt/emacs-plus/Emacs.app  --args --debug-init
# open -n -a /opt/homebrew/opt/emacs-plus@28/Emacs.app  --args --debug-init

arch_name="$(uname -m)"

# Check if an emacs server is available
# (by checking to see if it will evaluate a lisp statement)

if [ "${arch_name}" = "x86_64" ]; then
    # for Homebrew d12frosted/emacs-plus builds --with-xwidgets

    # next release Emacs 28 --with-native-comp
    if [ -d /usr/local/opt/emacs-plus@28/Emacs.app/ ] ; then
        EMACSPATH=/usr/local/opt/emacs-plus@28/Emacs.app/Contents/MacOS
        EMACSPATH_BIN="${EMACSPATH}/../../../bin"
        EMACS_WRAPPER_OR_BIN="${EMACSPATH}"/Emacs
    # for Homebrew emacs cask http://emacsformacosx.com
    elif [ -d /Applications/Emacs.app/ ] ; then
        EMACSPATH=/Applications/Emacs.app/Contents/MacOS
        EMACSPATH_BIN="${EMACSPATH}/bin"
        if [[ ! -d "${EMACSPATH_BIN}" ]] ; then
            if [[ -d "${EMACSPATH}/bin-x86_64-10_14" ]] ; then
                EMACSPATH_BIN="${EMACSPATH}/bin-x86_64-10_14"
            fi
        fi
        EMACS_WRAPPER_OR_BIN="${EMACSPATH}"/Emacs
        if [[ ! -x "${EMACSPATH}"/Emacs-x86_64-10_14 ]] ; then
            EMACS_WRAPPER_OR_BIN="${EMACSPATH}"/Emacs-x86_64-10_14
        fi
    fi

elif [ "${arch_name}" = "arm64" ]; then
    # Emacs 29 usually built --with-native-comp --with-xwidgets
    if [ -d /opt/homebrew/opt/emacs-plus@29/Emacs.app/ ] ; then
        EMACSPATH=/opt/homebrew/opt/emacs-plus@29/Emacs.app/Contents/MacOS
    # emacs-plus Emacs 28
    elif [ -d /opt/homebrew/opt/emacs-plus@28/Emacs.app/ ] ; then
        EMACSPATH=/opt/homebrew/opt/emacs-plus@28/Emacs.app/Contents/MacOS
    # emacs-plus "released" Emacs
    elif [ -d  /opt/homebrew/opt/emacs-plus/Emacs.app/ ] ; then
        EMACSPATH=/opt/homebrew/opt/emacs-plus/Emacs.app/Contents/MacOS
    # fall back to any (usually symlinked) Emacs 27
    elif [ -d /Applications/Emacs.app/ ] ; then
        EMACSPATH=/Applications/Emacs.app/Contents/MacOS
    fi

    # emacs-plus bin/ path
    if [ -d "${EMACSPATH}/../../../bin" ] ; then
        EMACSPATH_BIN="${EMACSPATH}/../../../bin"
    # emacs cask bin/ path
    elif [ -d "${EMACSPATH}/bin" ] ; then
        EMACSPATH_BIN="${EMACSPATH}/bin"
    else
        EMACSPATH_BIN="${EMACSPATH}/bin"
        echo Warning: Emacs /bin directory not found. Using "$EMACSPATH_BIN"
    fi

    EMACS_WRAPPER_OR_BIN="${EMACSPATH}"/Emacs

fi

# echo EMACSPATH=$EMACSPATH
# echo EMACSPATH_BIN=$EMACSPATH_BIN
# echo EMACS_WRAPPER_OR_BIN=$EMACS_WRAPPER_OR_BIN

# add to env so find-editor (magit) can locate emacsclient
export PATH="${EMACSPATH_BIN}":"$PATH"

# ASSUMES: emacsclient available at  "${EMACSPATH_BIN}"
if ! ("${EMACSPATH_BIN}"/emacsclient --eval "t"  2> /dev/null > /dev/null )
then
    # There is no server available so,
    # Start Emacs.app detached from the terminal
    # and change Emacs directory to PWD

    nohup "${EMACS_WRAPPER_OR_BIN}" --chdir "${PWD}" "${@}" 2>&1 > /dev/null &
else
    # The emacs server is available so use emacsclient

    if [ -z "${1}" ]
    then
        # There are no arguments, so
        # tell emacs to open a new window

        "${EMACSPATH_BIN}"/emacsclient --eval "(dired \"${PWD}\")"
    else
        # There are arguments, so
        # tell emacs to open them

        # `--no-wait` was problematic for `crontab -e` e.g., so do not use it
        # "${EMACSPATH_BIN}"/emacsclient --no-wait --create-frame "${@}"
        "${EMACSPATH_BIN}"/emacsclient --create-frame "${@}"
    fi

    # Bring emacs to the foreground
    #emacsclient --eval "(x-focus-frame nil)"
    # Bring emacs to the foreground
    which osascript > /dev/null 2>&1 && osascript -e 'tell application "Emacs" to activate'
fi

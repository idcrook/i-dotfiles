#!/bin/bash
#!/bin/bash -x

# Adapted from
# https://stackoverflow.com/a/38276432

# open --new -a /Applications/Emacs.app --args --debug-init

EMACSPATH=/Applications/Emacs26.app/Contents/MacOS

# Check if an emacs server is available
# (by checking to see if it will evaluate a lisp statement)

if ! (${EMACSPATH}/bin/emacsclient --eval "t"  2> /dev/null > /dev/null )
then
    # There is no server available so,
    # Start Emacs.app detached from the terminal
    # and change Emac's directory to PWD

    nohup ${EMACSPATH}/Emacs --chdir "${PWD}" "${@}" 2>&1 > /dev/null &
else
    # The emacs server is available so use emacsclient

    if [ -z "${1}" ]
    then
        # There are no arguments, so
        # tell emacs to open a new window

        ${EMACSPATH}/bin/emacsclient --eval "(dired \"${PWD}\")"
    else
        # There are arguments, so
        # tell emacs to open them

        ${EMACSPATH}/bin/emacsclient --no-wait --create-frame "${@}"
    fi

    # Bring emacs to the foreground
    #${EMACSPATH}/bin/emacsclient --eval "(x-focus-frame nil)"
fi

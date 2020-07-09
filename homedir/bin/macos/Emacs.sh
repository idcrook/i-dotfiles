#!/bin/bash
#!/bin/bash -x

# Adapted from
# https://stackoverflow.com/a/38276432

# open --new -a /Applications/Emacs.app --args --debug-init

EMACSPATH=/Applications/Emacs.app/Contents/MacOS

# Check if an emacs server is available
# (by checking to see if it will evaluate a lisp statement)
EMACSPATH_BIN="${EMACSPATH}/bin"
if [[ ! -d "${EMACSPATH_BIN}" ]] ; then
    if [[ -d "${EMACSPATH}/bin-x86_64-10_14" ]] ; then
        EMACSPATH_BIN="${EMACSPATH}/bin-x86_64-10_14"
    fi
fi

EMACS_WRAPPER_OR_BIN="${EMACSPATH}"/Emacs
if [[ ! -x  "${EMACSPATH}"/Emacs-x86_64-10_14 ]] ; then
    EMACS_WRAPPER_OR_BIN="${EMACSPATH}"/Emacs-x86_64-10_14
fi


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

        "${EMACSPATH_BIN}"/emacsclient --no-wait --create-frame "${@}"
    fi

    # Bring emacs to the foreground
    #${EMACSPATH}/bin/emacsclient --eval "(x-focus-frame nil)"
fi

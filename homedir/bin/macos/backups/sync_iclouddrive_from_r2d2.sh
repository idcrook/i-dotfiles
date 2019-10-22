#!/bin/bash
#!/bin/bash -x

USER="dpc"

SRC="/Users/$USER/Library/Mobile Documents/com~apple~CloudDocs/"
DEST="/Volumes/Documents/Backups/icloud_from_r2d2"

rsync=/usr/bin/rsync

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
RUNNING_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# try to make sure that "Documents" Volume is mounted
mount_script=mount_Documents_NAS
mount_script_plaintext="${mount_script}.applescript"
"${RUNNING_DIR}/$mount_script_plaintext"

# sleep 7
# exit

RSYNC_OPTS="-avr -4 --delete --delete-excluded --human-readable --progress  --delete-before --whole-file --times --stats --exclude-from=${RUNNING_DIR}/itunes_rsync_exclude "


if [[ ! -d "$SRC" ]]; then
    echo Cannot find backup src directory: "$SRC"
    echo Exitting
    exit 1
fi


if [[ ! -d "$DEST" ]]; then
    echo Cannot find backup target directory: "$DEST"
    echo Exitting
    exit 1
fi


cd "$SRC" || exit 1
pwd
$rsync ${RSYNC_OPTS} ./ "$DEST/"

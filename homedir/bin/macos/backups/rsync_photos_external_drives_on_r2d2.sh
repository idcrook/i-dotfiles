#!/bin/bash -x

server=n5550

src_media="/Volumes/PHOTOS_BACK_HFS"
dest_media="/Volumes/PHOTOS_"
rsync=/usr/bin/rsync
cp=/bin/cp

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
RUNNING_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# # try to make sure that "Music" Volume is mounted
# mount_script=mount_Pictures_NAS
# mount_script_plaintext="${mount_script}.applescript"
# "${RUNNING_DIR}/$mount_script_plaintext"

# sleep 7
# exit

#DEBUG# RSYNC_OPTS="-avr -4 --delete --progress --modify-window=1 --list-only "
#
RSYNC_OPTS="-avr -4 --delete --delete-excluded --human-readable --progress --stats --exclude-from=/Users/dpc/bin/macos/backups/itunes_rsync_exclude "

if [[ ! -d $src_media ]]; then
    echo Cannot find backup src directory: $src_media
    echo Exitting
    exit 1
fi


if [[ ! -d $dest_media ]]; then
    echo Cannot find backup target directory: $dest_media
    echo Exitting
    exit 1
fi

current_date=`date  +%Y-%m-%d`

cd "$src_media"
pwd
$rsync $RSYNC_OPTS ./ "$dest_media/"

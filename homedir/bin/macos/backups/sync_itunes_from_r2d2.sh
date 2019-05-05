#!/bin/bash
#!/bin/bash -x

src_media="/Users/dpc/Music/iTunes/iTunes Media"
dest_media="/Volumes/Multimedia/Music/iTunesData/iTunes Media"
rsync=/usr/bin/rsync
cp=/bin/cp

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
RUNNING_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# try to make sure that "Music" Volume is mounted
mount_script=mount_Multimedia_NAS
mount_script_plaintext="${mount_script}.applescript"
"${RUNNING_DIR}/$mount_script_plaintext"

# sleep 7
# exit

#DEBUG# RSYNC_OPTS="-avr -4 --delete --progress --modify-window=1 --list-only "
RSYNC_OPTS="-avr -4 --delete --delete-excluded --human-readable --progress --stats --exclude-from=${RUNNING_DIR}/itunes_rsync_exclude "

if [[ ! -d $src_media ]]; then
    echo Cannot find backup src directory: "$src_media"
    echo Exitting
    exit 1
fi


if [[ ! -d $dest_media ]]; then
    echo Cannot find backup target directory: "$dest_media"
    echo Exitting
    exit 1
fi

# backup library .XML
current_date=$(date  +%Y-%m-%d)
music_lib_xml_noext="iTunes Library"
music_lib_xml="${music_lib_xml_noext}.xml"
src_lib_file="/Users/dpc/Music/iTunes/$music_lib_xml"
dst_lib_file="${dest_media}/../${music_lib_xml_noext}-${current_date}.xml"
$cp -v "$src_lib_file" "$dst_lib_file"

cd "$src_media" || exit 1
pwd
$rsync ${RSYNC_OPTS} ./ "$dest_media/"

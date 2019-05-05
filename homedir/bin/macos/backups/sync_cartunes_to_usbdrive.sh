#!/bin/bash -x
# shellcheck disable=SC2086
# shellcheck disable=SC2191

# Sync a USB thumb drive that has staged contents on a network volume
#
# - Only does one USB drive at a time
# - looks for the drived to be mounted in /Volumes by USB drive VOLUME_NAME

src_media="/Volumes/Music/CarTunes"
# mapping
#     CARTUNES_1 -> CARPC (16GB Sandisk Cruzer)
#     CARTUNES_2 -> CARTUNES (32GB PNY)
src_media1="CARTUNES_1"
src_media2="CARTUNES_2"
dest_media1="/Volumes/CARPC"
dest_media2="/Volumes/CARTUNES"
rsync=/usr/local/bin/rsync

# If there are rsync errors around cannot read the '.Spotlight-V100' directory
# on the thumbdrive this is macOS Spotlight related.  Need to remove the
# directory so that rsync completes all operations (like delete) correctly
#
# Turn off spotlight in the sync source data
#     touch /Volumes/Music/CarTunes/CARTUNES_1/.metadata_never_index
#     touch /Volumes/Music/CarTunes/CARTUNES_2/.metadata_never_index

# Turning off and removing problematic directory
#     (On linux) cd /media/dpc/CARPC && rm -rf .Spotlight-V100
#     sudo mdutil -i off /Volumes/CARTUNES/
#     sudo mdutil -E /Volumes/CARTUNES/
#     sudo mdutil -i off /Volumes/CARPC/
#     sudo mdutil -E /Volumes/CARPC/
# These should report: "Indexing and searching disabled."
#     sudo mdutil -i on /Volumes/CARTUNES/
#     sudo mdutil -i on /Volumes/CARPC/

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-what-directory-its-stored-in
RUNNING_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# try to make sure that "Music" Volume (network share) is mounted
mount_script=mount_Music_NAS
mount_script_plaintext="${mount_script}.applescript"
"${RUNNING_DIR}/$mount_script_plaintext"

RSYNC_OPTS=(--archive --verbose --recursive --itemize-changes --progress --human-readable --exclude='*.m3u' --exclude='desktop.ini' --exclude='._*.jpg' --exclude='._*' --exclude='.fseventsd' --delete --delete-excluded --modify-window=2)

if [[ ! -d $src_media ]]; then
    echo ERROR: Cannot find src directory: $src_media
    echo Exiting
    exit 1
fi


# current_date=`date  +%Y-%m-%d`

# parent directory

cd "$src_media"  || exit 1
pwd

# check for USB drives
if [[ ! -d "${dest_media1}"/ && ! -d "${dest_media2}"/ ]]; then
    echo "ERROR: Cannot find any target volume(s): $dest_media1 $dest_media2"
    echo Exiting
    exit 2
fi

$rsync --version

# do the rsyncs
if [[ -d "${dest_media1}"/ ]]; then
    if [[ -d "${src_media1}"/ ]]; then
        echo INFO: Syncing "${src_media1}"/ to "${dest_media1}"
        $rsync ${RSYNC_OPTS[*]} "${src_media1}"/ "${dest_media1}"
        echo diskutil eject \""${dest_media1}"\"
    else
        echo WARNING: Did not find "${src_media1}"/
    fi
elif [[ -d "${dest_media2}"/ ]]; then
    if [[ -d "${src_media2}"/ ]]; then
        echo INFO: Syncing "${src_media2}"/ to "${dest_media2}"
        $rsync ${RSYNC_OPTS[*]} "${src_media2}"/ "${dest_media2}"
        echo diskutil eject \""${dest_media2}"\"
    else
        echo WARNING: Did not find "${src_media2}"/
    fi
else
    echo WARNING: Did not find any destination volumes
    echo Looked for "${dest_media1}"/
    echo Looked for "${dest_media2}"/
fi

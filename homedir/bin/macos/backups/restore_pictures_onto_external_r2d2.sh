#!/bin/bash -x

src_dir=/Volumes/Pictures/restore
dst_dir=/Volumes/PHOTOS_BACK_HFS

# rsync --recursive --progress --itemize-changes  $src_dir $dst_dir


if [[ ! -d $src_dir ]]; then
    echo Cannot find backup src directory: $src_dir
    echo Exitting
    exit 1
fi


if [[ ! -d $dst_dir ]]; then
    echo Cannot find backup target directory: $dst_dir
    echo Exitting
    exit 1
fi

# 
rsync -rum --verbose --progress --itemize-changes  $src_dir $dst_dir

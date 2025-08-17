#!/bin/bash

while true; do
    if pgrep mds_stores > /dev/null; then
        pkill -9 mds_stores
        echo "$(date '+%Y-%m-%d %H:%M:%S') - mds_stores stopped"
    fi
    sleep 2
done

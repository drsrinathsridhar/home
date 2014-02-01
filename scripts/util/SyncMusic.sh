#!/bin/bash
# This scripts connects to an Android device via ssh and syncs music via rsync+ssh
# Tested on Debian 7 and Android 4.2.2 Jelly Bean
# [ Last update ]: 2013-Jun-01
# [ USAGE ]: bash SyncMusic.sh <ip_address>

if [ $# -eq 0 ]
    then
        echo "[ USAGE ]: bash SyncMusic.sh <ip_address>"
        exit
fi

SOURCE_DIR=/media/MULTIMEDIA/Songs
DEST_DIR=/sdcard/Music
PHONE_IP=$1

# shopt -s globstar
# rsync -aL --size-only --no-perms --whole-file --compress --delete --verbose --omit-dir-times --include=*.mp3 --exclude=* -e ssh ${SOURCE_DIR}/**/. ${PHONE_IP}:${DEST_DIR}/.

# Keep directory structure
rsync -r -aL --size-only --no-perms --whole-file --compress --delete --ignore-times --include=*.mp3 --exclude "*.png" --exclude "*.ini" --exclude "*.jpg" --verbose -e ssh ${SOURCE_DIR}/ ${PHONE_IP}:${DEST_DIR}/

echo "Done syncing!"

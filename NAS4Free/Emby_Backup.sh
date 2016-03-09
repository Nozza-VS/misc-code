#!/bin/sh

# Backup script for Emby Media Server (AKA MediaBrowser)
# Version 1.01 (March 10, 2016)
# Taken directly from my update script

# Grab the date & time to be used later
date=$(date +"%Y.%m.%d-%I.%M%p")

# Add some colour!
nc='\033[0m'        # No Color
msg='\033[1;37m'    # Message Text
sep='\033[1;30m-------------------------------------------------------\033[0m'    # Line Seperator
cmd='\033[1;35m'    # Command to be entered

# Define our bail out shortcut function anytime there is an error - display
# the error message, then exit returning 1.
exerr () { echo -e "$*" >&2 ; exit 1; }


echo " "
echo -e "${sep}"
echo -e "${msg}   Welcome to the Emby Server backup script!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's start with the backup${nc}"
echo -e "${sep}"
echo " "

# Application backup
mkdir -p /usr/local/lib/emby-server-backup/${date} # Using -p in case you've never run the script before or you have deleted this folder
cp -R /usr/local/lib/emby-server/ /usr/local/lib/emby-server-backups/${date}

# Server data backup
mkdir -p /usr/local/lib/emby-server-backup/${date}
cp -R /var/db/emby-server/ /var/db/emby-server-backups/${date}

echo " "
echo -e "${sep}"
echo -e "${msg} That should be it!${nc}"
echo " "
echo " "
echo " "
echo -e "${msg} If something goes wrong with Emby you can do${nc}"
echo -e "${msg} the following to restore the old version:${nc}"
echo -e "${cmd}   rm -r /usr/local/lib/emby-server${nc}"
echo -e "${cmd}   mv /usr/local/lib/emby-server-backups/${date} /usr/local/lib/emby-server${nc}"
echo " "
echo -e "${msg} And use this to restore your server database/settings:${nc}"
echo -e "${cmd}   rm -r /var/db/emby-server${nc}"
echo -e "${cmd}   mv /var/db/emby-server-backups/${date} /var/db/emby-server${nc}"
echo -e "${sep}"
echo " "

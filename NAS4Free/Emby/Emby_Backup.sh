#!/bin/sh

# Backup script for Emby Media Server (AKA MediaBrowser)
# Version 1.03 (March 31, 2016)
# Taken directly from my update script

# Grab the date & time to be used later
date=$(date +"%Y.%m.%d-%I.%M%p")

# Add some colour!
nc='\033[0m'        # No Color
msg='\033[1;37m'    # Message Text
sep='\033[1;30m-------------------------------------------------------\033[0m'    # Line Seperator
cmd='\033[1;35m'    # Command to be entered
fin='\033[0;32m'
inf='\033[0;33m'

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
echo -e "${msg}   We require rsync for this, jails won't have it by${nc}"
echo -e "${msg}   default.${nc}"
echo -e "${sep}"
echo " "

pkg install -y rsync

echo " "
echo -e "${sep}"
echo -e "${msg}   Let's get to the backup${nc}"
echo -e "${sep}"
echo " "

# Swapping to rsync rather than cp so we can see progress actually happen on the backup for large servers.
pkg install -y rsync

echo " "
echo -e "${sep}"
echo -e "${msg} Create backups${nc}" # TODO: Give user option to backup or not
echo -e "${sep}"
echo " "

echo -e "${msg} Application backup${nc}"
mkdir -p /usr/local/lib/emby-server-backups/${date} # Using -p in case you've never run the script before or you have deleted this folder
rsync -a --info=progress2 /usr/local/lib/emby-server/ /usr/local/lib/emby-server-backups/${date}
#cp -r /usr/local/lib/emby-server/ /usr/local/lib/emby-server-backups/${date}
echo -e "${fin}    Application backup done..${nc}"

echo " "

echo -e "${msg} Server data backup ${inf}(May take a while)${nc}"
mkdir -p /var/db/emby-server-backups/${date}
rsync -a --info=progress2 /var/db/emby-server/ /var/db/emby-server-backups/${date}
#cp -r /var/db/emby-server/ /var/db/emby-server-backups/${date}
echo -e "${fin}    Server backup done.${nc}"

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

#!/bin/sh

# Update script for Emby Media Server (AKA MediaBrowser)
# Version 1.01 (February 21, 2016)
# As ports official freebsd ports tree takes ages to accept updates
# here is a simple script to grab the latest version and upgrade manually.

# Emby version to download
embyver="3.0.5871"  # Current latest version as of February 21, 2016.
                    # The current latest BSD package is version 3.0.5781.2

# Grab the date & time to be used later
date=$(date +"%Y.%m.%d-%I.%M%p")

confirm ()
{
# Confirm with the user
read -r -p "   Are you sure you wish to continue? [Y/n] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              echo " "
              echo -e "${url} Alright, let's continue.${nc}"
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo -e "${alt}    Stopping script..${nc}"
              echo " "
              exit
              ;;
esac
}

# Add some colour!
nc='\033[0m'        # No Color
alt='\033[0;31m'    # Alert Text
emp='\033[1;31m'    # Emphasis Text
msg='\033[1;37m'    # Message Text
url='\033[1;32m'    # URL
qry='\033[0;36m'    # Query Text
sep='\033[1;30m-------------------------------------------------------\033[0m'    # Line Seperator
cmd='\033[1;35m'    # Command to be entered

# Define our bail out shortcut function anytime there is an error - display
# the error message, then exit returning 1.
exerr () { echo -e "$*" >&2 ; exit 1; }


echo " "
echo -e "${sep}"
echo -e "${msg}   Welcome to the Emby Server updater!${nc}"
echo -e "${sep}"
echo " "
echo -e "${emp} CAUTION: This will remove the ability to restart${nc}"
echo -e "${emp} your Emby Server via the web dashboard!${nc}"
echo " "
echo -e "${msg} If you need to restart the server, you can with:${nc}"
echo -e "${cmd}    service emby-server restart${nc}"
echo " "
echo -e "${qry} Reminder${msg}: make sure you have modified the 'embyver'"
echo -e "${msg} line at the top of this script to the latest version."
echo " "
echo -e "${msg} Only continue if you are 100% sure${nc}"
confirm
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's start with a backup${nc}"
echo -e "${sep}"
echo " "

# Application backup
mkdir -p /usr/local/lib/emby-server-backup/${date}
cp /usr/local/lib/emby-server/ /usr/local/lib/emby-server-backups/${date}

# Server data backup
mkdir -p /usr/local/lib/emby-server-backup/${date}
cp /var/db/emby-server/ /var/db/emby-server-backups/${date}

# Emby BSD package version will always be below latest release so
# removing the next steps for the time being.

# echo " "
# echo -e "${sep}"
# echo -e "${msg} Now let's check for BSD upgrades${nc}"
# echo -e "${sep}"
# echo " "

# pkg update
# pkg upgrade emby-server

echo " "
echo -e "${sep}"
echo -e "${msg}   Grab the update${nc}"
echo -e "${sep}"
echo " "

fetch --no-verify-peer -o /tmp/emby-${embyver}.zip https://github.com/MediaBrowser/Emby/releases/download/${embyver}/Emby.Mono.zip

echo " "
echo -e "${sep}"
echo -e "${msg} Download done, let's stop the server${nc}"
echo -e "${sep}"
echo " "

service emby-server stop

echo " "
echo -e "${sep}"
echo -e "${msg} Now to extract the download and replace old version${nc}"
echo -e "${sep}"
echo " "

unzip "/tmp/emby-${embyver}.zip" -d /usr/local/lib/emby-server

service emby-server start

echo " "
echo -e "${sep}"
echo -e "${msg} That should be it!${nc}"
echo -e "${msg} Now head to your Emby dashboard to ensure it's up to date.${nc}"
echo " "
echo " "
echo " "
echo -e "${msg} If something went wrong you can do the following to restore the old version:${nc}"
echo -e "${cmd}   rm -r /usr/local/lib/emby-server${nc}"
echo -e "${cmd}   mv /usr/local/lib/emby-server-backups/${date} /usr/local/lib/emby-server${nc}"
echo " "
echo -e "${msg} And use this to restore your server database/settings:${nc}"
echo -e "${cmd}   rm -r /var/db/emby-server${nc}"
echo -e "${cmd}   mv /var/db/emby-server-backups/${date} /var/db/emby-server${nc}"
echo -e "${sep}"
echo " "

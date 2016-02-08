#!/bin/sh

# Update script for Emby Media Server (AKA MediaBrowser)
# Version 1.0 (February 8, 2016)
# As ports official freebsd ports tree takes ages to accept updates
# here is a simple script to grab the latest version and upgrade manually.

# Emby version to download
embyver="3.0.5821"

# Grab the date & time to be used later
date=$(date +"%Y.%m.%d-%I.%M%p")

confirm ()
{
# Confirm with the user
read -r -p "   Continue? [Y/n] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              echo -e "${url} Alright, let's continue.${nc}"
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo " Looks like there's nothing left to do"
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
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's start with a backup${nc}"
echo -e "${sep}"
echo " "

mkdir -p /usr/local/lib/emby-server-backup/${date}
cp /usr/local/lib/emby-server/ /usr/local/lib/emby-server-backup/${date}

# echo " "
# echo -e "${sep}"
# echo -e "${msg} Now let's check for BSD upgrades${nc}"
# echo -e "${sep}"
# echo " "

# pkg update
# pkg upgrade emby-server

# echo " "
# echo -e "${sep}"
# echo -e "${msg} Check to see if there is still an update${nc}"
# echo -e "${sep}"
# echo " "

echo " Head to your Emby Dashboard"
echo " Under 'Server Information' check to see if it still says"
echo " that there is an update available"
echo " "
echo " Is there a new version available for download?"
confirm
echo " "
fetch --no-verify-peer -o /tmp/emby-${embyver}.zip https://github.com/MediaBrowser/Emby/releases/download/${embyver}/Emby.Mono.zip

echo " "
echo -e "${sep}"
echo -e "${msg} Dowload done, let's stop the server${nc}"
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

# echo " Would you like to clear the backup folder?"
# echo " "
# confirm
# echo " "

#!/bin/sh
# AIO script for Emby Media Server (AKA MediaBrowser)
# Version 1.0.0 (March 28, 2016)
################################################################################
##### START OF CONFIGURATION SECTION #####
######
# Emby version to download
#embyver="latest" # Uncomment to get latest, must comment out the next line too.
embyver="3.0.5911"  # Current latest version as of March 28, 2016.
                    # The current latest BSD package is version 3.0.5781.2_1
#####
### No need to edit below here ###
##### END OF CONFIGURATION SECTION #####
################################################################################



# Grab the date & time to be used later
date=$(date +"%Y.%m.%d-%I.%M%p")

# Add some colour!
nc='\033[0m'        # No Color
alt='\033[0;31m'    # Alert Text
emp='\033[1;31m'    # Emphasis Text
msg='\033[1;37m'    # Message Text
url='\033[1;32m'    # URL
qry='\033[0;36m'    # Query Text
sep='\033[1;30m-------------------------------------------------------\033[0m'    # Line Seperator
cmd='\033[1;35m'    # Command to be entered
fin='\033[0;32m'    # Green Text
inf='\033[0;33m'    # Information Text

# Define our bail out shortcut function anytime there is an error - display
# the error message, then exit returning 1.
exerr () { echo -e "$*" >&2 ; exit 1; }



################################################################################
##### INSTALLER
################################################################################

embyinstall ()
{
pkg install -y emby-server
sysrc emby_server_enable="YES"
service emby-server start
}

################################################################################
##### UPDATER
################################################################################
### USING LATEST VERSION FROM GITHUB

embyupdate ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's start with a backup.${nc}"
echo -e "${msg}   First, make sure we have rsync and then${nc}"
echo -e "${msg}   we will use it to create a backup${nc}"
echo -e "${sep}"
echo " "

# Using rsync rather than cp so we can see progress actually happen on the backup for large servers.
pkg install -y rsync

echo " "
echo -e "${sep}"
echo " "

echo -e "${emp} Application backup${nc}"
mkdir -p /usr/local/lib/emby-server-backups/${date} # Using -p in case you've never run the script before or you have deleted this folder
rsync -a --info=progress2 /usr/local/lib/emby-server/ /usr/local/lib/emby-server-backups/${date}
echo -e "${fin}    Application backup done..${nc}"

echo " "

echo -e "${emp} Server data backup ${inf}(May take a while)${nc}"
mkdir -p /var/db/emby-server-backups/${date}
rsync -a --info=progress2 /var/db/emby-server/ /var/db/emby-server-backups/${date}
echo -e "${fin}    Server backup done.${nc}"

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

unzip -o "/tmp/emby-${embyver}.zip" -d /usr/local/lib/emby-server

echo " "
echo -e "${sep}"
echo -e "${msg} And finally, start the server back up.${nc}"
echo -e "${sep}"
echo " "

service emby-server start

echo " "
echo -e "${sep}"
echo -e "${msg} That should be it!${nc}"
echo -e "${msg} Now head to your Emby dashboard to ensure it's up to date.${nc}"
echo -e "${msg} (Refresh the page if you already have Emby open)${nc}"
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
echo -e "${msg} You can get in touch with me any of the ways listed here:${nc}"
echo -e "${url} http://vengefulsyndicate.com/about-us${nc}"
echo -e "${msg}      Happy Streaming!${nc}"
echo " "
echo -e "${sep}"
echo " "
}

#------------------------------------------------------------------------------#
### SAFE UPDATE (USING PACKAGES)
#------------------------------------------------------------------------------#

embyupdatesafe ()
{
pkg update
pkg upgrade emby-server
}

################################################################################
##### BACKUP
################################################################################

embybackup ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   First, make sure we have rsync and then${nc}"
echo -e "${msg}   we will use it to create a backup${nc}"
echo -e "${sep}"
echo " "

# Using rsync rather than cp so we can see progress actually happen on the backup for large servers.
pkg install -y rsync

echo " "
echo -e "${sep}"
echo " "

echo -e "${emp} Application backup${nc}"
mkdir -p /usr/local/lib/emby-server-backups/${date} # Using -p in case you've never run the script before or you have deleted this folder
rsync -a --info=progress2 /usr/local/lib/emby-server/ /usr/local/lib/emby-server-backups/${date}
echo -e "${fin}    Application backup done..${nc}"

echo " "

echo -e "${emp} Server data backup ${inf}(May take a while)${nc}"
mkdir -p /var/db/emby-server-backups/${date}
rsync -a --info=progress2 /var/db/emby-server/ /var/db/emby-server-backups/${date}
echo -e "${fin}    Server backup done.${nc}"

echo " "
echo -e "${sep}"
echo -e "${msg} That should be it!${nc}"
echo " "
echo " "
echo " "
echo -e "${msg} If something goes wrong you can do the following to restore an old version:${nc}"
echo -e "${cmd}   rm -r /usr/local/lib/emby-server${nc}"
echo -e "${cmd}   mv /usr/local/lib/emby-server-backups/${date} /usr/local/lib/emby-server${nc}"
echo " "
echo -e "${msg} And use this to restore your server database/settings:${nc}"
echo -e "${cmd}   rm -r /var/db/emby-server${nc}"
echo -e "${cmd}   mv /var/db/emby-server-backups/${date} /var/db/emby-server${nc}"
echo -e "${sep}"
echo " "
}
################################################################################
##### CONFIRMATIONS
################################################################################
### INSTALL CONFIRMATION

confirmembyinstall ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Emby Server Installer.${nc}"
echo -e "${sep}"
echo " "
echo -e "${emp} NOTE: It's best to install this inside of a jail.${nc}"
echo -e "${msg} You CAN install it without one if you choose though.${nc}"
# Confirm with the user
read -r -p "   Confirm Installtion of Emby Media Server? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              embyinstall
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### BACKUP CONFIRMATIONS
#------------------------------------------------------------------------------#

confirmembybackup ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Emby Server Backup${nc}"
echo -e "${sep}"
echo " "
echo -e "${msg} Server Application Backup Location:${nc}"
echo -e "${inf}    /usr/local/lib/emby-server-backups/${nc}"
echo " "
echo -e "${msg} Server Data/Configuration Backup Location:${nc}"
echo -e "${inf}    /var/db/emby-server-backups/${nc}"
echo " "
# Confirm with the user
read -r -p "   Confirm Backup of Emby?? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              embyupdate
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### UPDATE CONFIRMATIONS
#------------------------------------------------------------------------------#

confirmembyupdatesafe ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Emby Server updater (Safe method)${nc}"
echo -e "${sep}"
echo " "
echo -e "${emp} NOTE: This update method will not always be the very${nc}"
echo -e "${emp} latest version as BSD packages are updated slower${nc}"
echo -e "${emp} but this method won't break anything.${nc}"
echo " "
echo -e "${msg} Only continue if you are 100% sure${nc}"
echo -e "${inf} (Will also do a backup)${nc}"
# Confirm with the user
read -r -p "   Confirm Update of Emby Media Server? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              embyupdatesafe
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
echo " "
echo " "
}

confirmembyupdategit ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Emby Server updater (Latest method)${nc}"
echo -e "${sep}"
echo " "
echo -e "${emp} CAUTION: This will remove the ability to restart your${nc}"
echo -e "${emp}          Emby Server via the web dashboard!${nc}"
echo " "
echo -e "${msg} If you need to restart the server, you can with:${nc}"
echo -e "${cmd}    service emby-server restart${nc}"
echo " "
echo -e "${qry} Reminder${msg}: make sure you have modified the 'embyver'${nc}"
echo -e "${msg} line at the top of this script to the latest version.${nc}"
echo " "
echo -e "${msg} Only continue if you are 100% sure${nc}"
echo -e "${inf} (Will also do a backup)${nc}"
# Confirm with the user
read -r -p "   Confirm Update of Emby Media Server? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              embyupdate
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
echo " "
echo " "
}

################################################################################
##### MAIN MENU
################################################################################

mainmenu=""

while [ "$choice" != "q" ]
do
        echo -e "${sep}"
        echo " "
        echo -e "${fin} Emby Server Script${nc}"
        echo -e "${inf}    Script Version: 1.0.0 (March 28, 2016)"
        echo " "
        echo -e "${emp} Main Menu"
        echo " "
        echo -e "${qry} Please make a selection!"
        echo " "
        echo -e "${fin}   1)${msg} Install${nc}"
        echo -e "${fin}   2)${msg} Update via Packages ${inf}(Safe)${nc}"
        echo -e "${fin}   3)${msg} Update via GitHub ${inf}(More Up To Date)${nc}"
        echo -e "${fin}   4)${msg} Backup${nc}"
        echo " "
        echo -e "${alt}  q) Quit${nc}"
        echo -e "${sep}"

        read -r -p "   Option: " choice

        case $choice in
            '1')
                confirmembyinstall
                ;;
            '2')
                confirmembyupdatesafe
                ;;
            '3')
                confirmembyupdategit
                ;;
            '4')
                confirmembybackup
                ;;
            'q') echo -e "${alt}        Exiting script!${nc}"
                echo " "
                ;;
            *)   echo -e "${emp}        Invalid choice, please try again${nc}"
                ;;
        esac
done

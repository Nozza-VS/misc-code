#!/bin/sh
# Emby Script                   Version: 1.0.3 (April 6, 2016)
# By Ashley Townsend (Nozza)    Copyright: Beerware License
################################################################################
# While using "nano" to edit this script (nano /aioscript.sh),
# Use the up, down, left and right arrow keys to navigate. Once done editing,
# Press "X" while holding "Ctrl", Press "Y" then press "Enter" to save changes
################################################################################
##### START OF CONFIGURATION SECTION #####
######
# Emby version to download
emby_update_ver="3.0.5912"  # You may use the version number or use "latest"
                            # Current latest version as of April 6, 2016.
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
ca='\033[1;30m'     # Currently Unavailable (Dark Grey Text)

# Define our bail out shortcut function anytime there is an error - display
# the error message, then exit returning 1.
exerr () { echo -e "$*" >&2 ; exit 1; }



################################################################################
##### CONTACT
################################################################################

gethelp ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} Ways of contacting me / Getting help from others:${nc}"
        echo -e "${sep}"
        echo " "
        echo -e "${fin}   ${ul}My Discord Support${fin} (Usually faster responses):${nc}"
        echo -e "${msg}      https://discord.gg/0bXnhqvo189oM8Cr${nc}"
        echo -e "${fin}   ${ul}My Email${fin} (Might add this later, Discord is easier though):${nc}"
        echo -e "${msg}      myemail@domain.com${nc}"
        echo -e "${fin}   ${ul}Forums:${nc}"
        echo -e "${msg}      VS Forums:${nc}"
        echo -e "${url}      forums.vengefulsyndicate.com${nc}"
        echo " "
        echo -e "${fin}   Find an issue with the script or have a suggestion?${nc}"
        echo -e "${msg}   Drop a message using the above or head here:${nc}"
        echo -e "${url}      https://github.com/Nostalgist92/misc-code/issues"
        echo " "
        echo -e "${emp}   Press Enter To Go Back To The Menu${nc}"
        echo -e "${msep}"

        read choice

        case $choice in
            *)
                 return
                 ;;
        esac
done
}



################################################################################
##### INFORMATION / ABOUT
################################################################################

#------------------------------------------------------------------------------#
### ABOUT
#------------------------------------------------------------------------------#

about ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: Emby Media Server${nc}"
        echo " "
        echo -e "${msg} Emby Server is a home media server built on top of other popular open source${nc}"
        echo -e "${msg} technologies such as Service Stack, jQuery, jQuery  mobile, and Mono.${nc}"
        echo " "
        echo -e "${msg} It features a REST-based API with built-in documention to  facilitate client${nc}"
        echo -e "${msg} development. It also has client libraries for API to enable rapid development.${nc}"
        echo " "
        echo -e "${sep}"
        echo " "
        echo -e "${inf} About: This Script${nc}"
        echo -e "${msg} The aim of this script is to provide an as automated as possible${nc}"
        echo -e "${msg} way of setting up your own Emby Media Server${nc}"
        echo " "
        echo -e "${msg} Wish to contribute? Feel free to drop me a message anyhere listed in the${nc}"
        echo -e "${msg} 'Contact / Get Help' menu.${nc}"
        echo " "
        echo -e "${msg} Like my work enough to buy me a pizza? Please do!${nc}"
        echo -e "${url} https://www.paypal.me/AshleyTownsend${nc}"
        echo -e "${sep}"
        echo " "

        echo -e "${msep}"
        echo -e "${emp}   Press Enter To Go Back To The Menu${nc}"
        echo -e "${msep}"

        read choice

        case $choice in
            *)
                 return
                 ;;
        esac
done
}



################################################################################
##### HOW-TO'S
################################################################################

#------------------------------------------------------------------------------#
### EMBY - HOW-TO: RESTART THE SERVER
#------------------------------------------------------------------------------#

emby.howto.restartserver
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} Emby - How to restart your server${nc}"
        echo -e "${sep}"
        echo " "
        echo -e "${msg} If you need to restart the server, you can with:${nc}"
        echo -e "${cmd}    service emby-server restart${nc}"
        echo " "

        echo -e "${msep}"
        echo -e "${emp}   Press Enter To Go Back To The Menu${nc}"
        echo -e "${msep}"

        read choice

        case $choice in
            *)
                 return
                 ;;
        esac
done
}



################################################################################
##### FIXES
################################################################################



################################################################################
##### INSTALLER
################################################################################

install.emby ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Emby Install Script${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's start with installing Emby from packages${nc}"
echo -e "${sep}"
echo " "

pkg install -y emby-server

echo " "
echo -e "${sep}"
echo -e "${msg}   Enable automatic startup of Emby Server${nc}"
echo -e "${sep}"
echo " "

sysrc emby_server_enable="YES"

echo " "
echo -e "${sep}"
echo -e "${msg}   Start the Emby Server${nc}"
echo -e "${sep}"
echo " "

service emby-server start

echo " "
echo -e "${sep}"
echo -e "${msg} Using a web browser, head to ${url}yourjailip:8096${nc}"
echo -e "${msg} to finish setting up your Emby server${nc}"
echo -e " "
echo -e "${msg} You should also recompile ffmpeg+imagemagick${nc}"
echo -e "${msg} This option can be found in the Emby submenu of this script${nc}"
echo -e "${sep}"
echo " "
}



################################################################################
##### UPDATER
################################################################################

update.emby ()
{

continue ()
{
while [ "$choice" ]
do
        echo " "
        echo -e "${msep}"
        echo -e "${emp}   Press Enter To Continue${nc}"
        echo -e "${msep}"
        echo " "

        read choice

        case $choice in
            *)
                 return
                 ;;
        esac
done
}

remove.old.backups ()
{
read -r -p "   Remove old backups? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then make a backup before proceeding
              rm -r /usr/local/lib/emby-server-backups/*
              rm -r /var/db/emby-server-backups/*
              ;;
    *)
              # Otherwise continue with backup...
              echo " "
              echo -e "${inf} Continuing with backup..${nc}"
              ;;
esac
}

create.emby.backup ()
{
# Confirm with the user
echo -e "${msg} Recommended if you haven't done so already:${nc}"
read -r -p "   Create a backup before updating? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then make a backup before proceeding
              echo " "
              echo -e "${sep}"
              echo -e "${msg}   Would you like to remove any old backups before creating a new one?${nc}"
              echo -e "${msg}   This helps reduce the amount of space used by backups.${nc}"
              echo -e "${sep}"
              echo " "

              remove.old.backups

              echo " "
              echo -e "${sep}"
              echo -e "${msg}   Make sure we have rsync and then use it to create a backup${nc}"
              echo -e "${sep}"
              echo " "

              # Using rsync rather than cp so we can see progress actually happen on the backup for large servers.
              pkg install -y rsync

              # If yes, then create backup
              echo " "
              echo -e "${sep}"
              echo -e "${msg} Running backups${nc}"
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
              ;;
    *)
              # Otherwise continue with update...
              echo " "
              echo -e "${inf} Skipping backup..${nc}"
              ;;
esac
}

recompile.from.ports ()
{
# Confirm with the user
echo -e "${msg} These steps could take some time${nc}"
read -r -p "   Would you like to recompile these now? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then make a backup before proceeding
              echo " "
              echo -e "${sep}"
              echo -e "${msg} First, lets do ImageMagick${nc}"
              echo -e "${msg} When the options pop up, disable (By pressing space when its highlighted):${nc}"
              echo -e "${inf}    16BIT_PIXEL   ${msg}(to increase thumbnail generation performance)${nc}"
              echo -e "${msg} and then press 'Enter'${nc}"
              echo " "

              continue

              cd /usr/ports/graphics/ImageMagick && make deinstall
              make clean && make clean-depends
              make config

              echo " "
              echo -e "${sep}"
              echo -e "${msg} Press 'OK'/'Enter' if any box that follows.${nc}"
              echo -e "${msg}    (There shouldn't be any that pop up)${nc}"
              echo -e "${sep}"
              echo " "

              continue

              make install clean

              echo " "
              echo -e "${sep}"
              echo -e "${msg} Great, now ffmpeg${nc}"
              echo -e "${msg} When the options pop up, enable (By pressing space when its highlighted):${nc}"

              echo -e "${inf}    ASS     ${msg}(required for subtitle rendering)${nc}"
              echo -e "${inf}    LAME    ${msg}(required for mp3 audio transcoding -${nc}"
              echo -e "${inf}            ${msg}disabled by default due to mp3 licensing restrictions)${nc}"
              echo -e "${inf}    OPUS    ${msg}(required for opus audio codec support)${nc}"
              echo -e "${inf}    X265    ${msg}(required for H.265 video codec support${nc}"
              echo -e "${msg} Then press 'OK' for every box that follows.${nc}"
              echo -e "${msg} This one may take a while, please be patient${nc}"
              echo -e "${sep}"
              echo " "

              continue

              cd /usr/ports/multimedia/ffmpeg && make deinstall
              make clean
              make clean-depends
              make config

              echo " "
              echo -e "${sep}"
              echo -e "${msg} Press 'OK'/'Enter' for every box that follows.${nc}"
              echo -e "${msg}    (There will be several that pop up)${nc}"
              echo -e "${sep}"
              echo " "

              continue

              make install clean

              echo " "
              echo -e "${sep}"
              echo -e "${msg} Finished with the recompiling!${nc}"
              echo -e "${sep}"
              echo " "

              ;;
    *)
              # Otherwise continue with update...
              echo " "
              echo -e "${inf} Skipping for now.. (You can do this later via the Emby menu)${nc}"
              ;;
esac
}

echo " "
echo -e "${sep}"
echo -e "${msg}   Emby Updater${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg} Shall we create a backup before updating?${nc}"
echo -e "${sep}"
echo " "

create.emby.backup

echo " "
echo -e "${sep}"
echo -e "${msg}   Update packages${nc}"
echo -e "${sep}"
echo " "

pkg update
pkg upgrade -y
pkg install -y emby-server # In case it gets deinstalled

echo " "

echo -e "${msg} Package updates done${nc}"

echo " "
echo -e "${sep}"
echo -e "${msg} Recompile ffmpeg and ImageMagick${nc}"
echo " "
echo -e "${msg} This is optional but to get the most out of your Emby Media Server${nc}"
echo -e "${msg} you will need to do this. (Can also be done at a later time)${nc}"
echo -e "${msg}    This can be done either later via Emby menus or now.${nc}"
echo -e "${msg}    Additional information can also be found in the menu.${nc}"
echo -e "${msg} You will also need the 'ports tree' enabled for this to work.${nc}"
echo -e "${sep}"
echo " "

recompile.from.ports

echo " "
echo -e "${sep}"
echo -e "${msg}   Grab the update from github${nc}"
echo -e "${sep}"
echo " "

fetch --no-verify-peer -o /tmp/emby-${emby_update_ver}.zip https://github.com/MediaBrowser/Emby/releases/download/${emby_update_ver}/Emby.Mono.zip

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

unzip -o "/tmp/emby-${emby_update_ver}.zip" -d /usr/local/lib/emby-server

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
echo -e "${msg}    (Refresh the page if you already have Emby open)${nc}"
echo " "
echo -e "${msg} If something went wrong you can do this to restore the old app version:${nc}"
echo -e "${cmd}   service emby-server stop${nc}"
echo -e "${cmd}   rm -r /usr/local/lib/emby-server${nc}"
echo -e "${cmd}   mv /usr/local/lib/emby-server-backups/${date} /usr/local/lib/emby-server${nc}"
echo -e "${cmd}   service emby-server start${nc}"
echo " "
echo -e "${msg} And use this to restore your server database/settings:${nc}"
echo -e "${cmd}   service emby-server stop${nc}"
echo -e "${cmd}   rm -r /var/db/emby-server${nc}"
echo -e "${cmd}   mv /var/db/emby-server-backups/${date} /var/db/emby-server${nc}"
echo -e "${cmd}   service emby-server start${nc}"
echo -e "${sep}"
echo -e "${msg} You can get in touch with me any of the ways listed here:${nc}"
echo -e "${url} http://vengefulsyndicate.com/about-us${nc}"
echo -e "${msg}      Happy Streaming!${nc}"
echo -e "${sep}"
echo " "

continue

}



################################################################################
##### BACKUP
################################################################################

backup.emby ()
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

#------------------------------------------------------------------------------#
### INSTALL CONFIRMATION
#------------------------------------------------------------------------------#

confirm.emby.install ()
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
              install.emby
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

confirm.backup.emby ()
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
              backup.emby
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

confirm.update.emby ()
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
              update.emby
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

while [ "$choice" != "a,h,i,q" ]
do
        echo -e "${sep}"
        echo " "
        echo -e "${fin} Emby Server Script${nc}"
        echo -e "${inf}    Script Version: 1.0.3 (April 6, 2016)"
        echo " "
        echo -e "${emp} Main Menu"
        echo " "
        echo -e "${qry} Please make a selection!"
        echo " "
        echo -e "${fin}   1)${msg} Install${nc}"
        echo -e "${fin}   2)${msg} Update${nc}"
        echo -e "${fin}   3)${msg} Backup${nc}"
        echo " "
        echo -e "${ca}  a) About Emby${nc}"
        echo -e "${ca}  i) More Info / How-To's (Currently Unavailable)${nc}"
        echo -e "${ca}  h) Get Help${nc}"
        echo " "
        echo " "
        echo -e "${alt}  q) Quit${nc}"
        echo -e "${sep}"

        read -r -p "   Option: " choice

        case $choice in
            '1')
                confirm.install.emby
                ;;
            '2')
                confirm.update.emby
                ;;
            '3')
                confirm.backup.emby
                ;;
            'a')
                about
                ;;
            'h')
                gethelp
                ;;
            #'i')
            #    moreinfo.submenu.emby
            #    ;;
            'q') echo -e "${alt}        Exiting script!${nc}"
                echo " "
                exit
                ;;
            *)   echo -e "${emp}        Invalid choice, please try again${nc}"
                ;;
        esac
done

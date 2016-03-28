#!/bin/sh
# Script Version: 1.0.1 (March 28, 2016)
# NOTE: Untested & Unfinished
# TODO: Finish script

#Grab the date & time to be used later
backupdate=$(date +"%Y.%m.%d-%I.%M%p")

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



################################################################################
##### CONTACT
################################################################################

contactme ()
{
while [ "$choice" ]
do
        echo -e "${inf} Ways of contacting me:${nc}"
        echo " "
        echo -e "${fin}   Discord:${nc}"
        echo -e "${msg}      https://discord.gg/0bXnhqvo189oM8Cr${nc}"
        echo -e "${fin}   Email:${nc}"
        echo -e "${msg}      myemail@domain.com${nc}"
        echo -e "${fin}   Forums:${nc}"
        echo -e "${msg}      forums.nas4free.org${nc}"
        echo -e "${msg}      forums.vengefulsyndicate.com${nc}"
        echo " "
        echo -e "${emp}   Press Enter To Go Back To The Main Menu${nc}"

        read choice

        case $choice in
            *)
                 return
                 ;;
        esac
done
}



################################################################################
##### INSTALLERS
# TODO: Finish the rest of the installers
################################################################################

#------------------------------------------------------------------------------#
### SONARR INSTALL
#------------------------------------------------------------------------------#

installsonarr ()
{
# Taken from Sonarr install script (In jail + root user version)
# Version 1.00 (March 15, 2016)
# This is for installations that followed the documented FreeBSD installation
# You can find this information here: https://github.com/Sonarr/Sonarr/wiki/FreeBSD-installation
# This can be used temporarily for when Built-In update mechanism fails or in place of it enitrely.

sep='\033[1;30m-------------------------------------------------------\033[0m'    # Line Seperator

echo " "
echo -e "${sep}"
echo "   Sonarr Install Script"
echo -e "${sep}"
echo " "

echo " "
echo -e "${sep}"
echo "   Let's start with installing Sonarr from packages"
echo -e "${sep}"
echo " "

pkg install -y sonarr

# Remove ffmpeg

# Build from ports tree # TODO: Add instructions on how

# Install new ffmpeg

# Start sonarr
service sonarr start

# TODO: Direct user to sonarr
}

#------------------------------------------------------------------------------#
### COUCHPOTATO INSTALL
#------------------------------------------------------------------------------#

installcouchpotato ()
{
#Install required tools
pkg install python py27-sqlite3 fpc-libcurl docbook-xml git-lite

#For default install location and running as root
cd /usr/local

#If running as root, expects python here
ln -s /usr/local/bin/python /usr/bin/python

#get couchpotato from git
git clone https://github.com/CouchPotato/CouchPotatoServer.git

#Copy the startup script
cp CouchPotatoServer/init/freebsd /usr/local/etc/rc.d/couchpotato

#Make startup script executable
chmod 555 /usr/local/etc/rc.d/couchpotato

#Add startup to boot
echo 'couchpotato_enable="YES"' >> /etc/rc.conf

#Read the options at the top of more /usr/local/etc/rc.d/couchpotato
#If not default install, specify options with startup flags in ee /etc/rc.conf
#Finally,

service couchpotato start
#Open your browser and go to: http://server:5050/
}

#------------------------------------------------------------------------------#
### HEADPHONES INSTALL
#------------------------------------------------------------------------------#

installheadphones ()
{
# Headphones Installation (Covers Music)
git clone https://github.com/rembo10/headphones.git

#Copy the startup script
# cp headphones/init-scripts/init.freebsd /usr/local/etc/rc.d/headphones
#Fetch Nostalgist92's startup script instead

#Make startup script executable
chmod 555 /usr/local/etc/rc.d/headphones

#Add startup to boot
echo 'headphones_enable="YES"' >> /etc/rc.conf

#Start the server
service headphones start

#Open your browser and go to: http://server:headphonesport?/
}



################################################################################
##### UPDATERS
# TODO: Start working on all applicable updaters
################################################################################

#------------------------------------------------------------------------------#
### SONARR UPDATE
#------------------------------------------------------------------------------#

updatesonarr ()
{

}

#------------------------------------------------------------------------------#
### COUCHPOTATO UPDATE
#------------------------------------------------------------------------------#

updatecouchpotato ()
{

}

#------------------------------------------------------------------------------#
### HEADPHONES UPDATE
#------------------------------------------------------------------------------#

updateheadphones ()
{

}



################################################################################
##### BACKUPS
# TODO: Start working on all applicable backups
################################################################################

#------------------------------------------------------------------------------#
### SONARR BACKUP
#------------------------------------------------------------------------------#

backupsonarr ()
{

}

#------------------------------------------------------------------------------#
### COUCHPOTATO BACKUP
#------------------------------------------------------------------------------#

backupcouchpotato ()
{

}

#------------------------------------------------------------------------------#
### HEADPHONES BACKUP
#------------------------------------------------------------------------------#

backupheadphones ()
{

}



################################################################################
##### SUBMENUS
# TODO: Add appropriate commands to backups option once finished
################################################################################

#------------------------------------------------------------------------------#
### SONARR SUBMENU
#------------------------------------------------------------------------------#

sonarrsubmenu ()
{
while [ "$choice" != "q" ]
do
        echo -e "${fin} Sonarr Options${nc}"
        echo
        echo -e "${qry} Choose one:"
        echo -e "${fin}   1)${msg} Install"
        echo -e "${fin}   2)${msg} Update"
        echo -e "${fin}   3)${msg} Backup"
        echo -e "${emp}   4) Main Menu${nc}"
        echo

        read choice

        case $choice in
            '1') echo -e "${inf} Installing..${nc}"
                confirmsonarrinstall
                ;;
            '2') echo -e "${inf} Running Update..${nc}"
                confirmsonarrupdate
                ;;
            '3') echo -e "${inf} Backup..${nc}"
                backupsonarr
                ;;
            '4') return
                ;;
        esac
done
}

#------------------------------------------------------------------------------#
### COUCHPOTATO SUBMENU
#------------------------------------------------------------------------------#

couchpotatosubmenu ()
{
while [ "$choice" != "q" ]
do
        echo -e "${fin} CouchPotato Options${nc}"
        echo
        echo -e "${qry} Choose one:"
        echo -e "${fin}   1)${msg} Install"
        echo -e "${fin}   2)${msg} Update"
        echo -e "${fin}   3)${msg} Backup"
        echo -e "${emp}   4) Main Menu${nc}"
        echo

        read choice

        case $choice in
            '1') echo -e "${inf} Installing..${nc}"
                confirmcouchpotatoinstall
                ;;
            '2') echo -e "${inf} Running Update..${nc}"
                confirmcouchpotatoupdate
                ;;
            '3') echo -e "${inf} Backup..${nc}"
                backupcouchpotato
                ;;
            '4') return
                ;;
        esac
done
}

#------------------------------------------------------------------------------#
### HEADPHONES SUBMENU
#------------------------------------------------------------------------------#

headphonessubmenu ()
{
while [ "$choice" != "q" ]
do
        echo -e "${fin} HeadPhones Options${nc}"
        echo
        echo -e "${qry} Choose one:"
        echo -e "${fin}   1)${msg} Install"
        echo -e "${fin}   2)${msg} Update"
        echo -e "${fin}   3)${msg} Backup"
        echo -e "${emp}   4) Main Menu${nc}"
        echo

        read choice

        case $choice in
            '1') echo -e "${inf} Installing..${nc}"
                confirmheadphonesinstall
                ;;
            '2') echo -e "${inf} Running Update..${nc}"
                confirmheadphonesupdate
                ;;
            '3') echo -e "${inf} Backup..${nc}"
                backupheadphones
                ;;
            '4') return
                ;;
        esac
done
}



################################################################################
##### CONFIRMATIONS
# TODO: Add confirms for all installs as a safety thing
################################################################################

#------------------------------------------------------------------------------#
### INSTALL CONFIRMATIONS
#------------------------------------------------------------------------------#

confirmsonarrinstall ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Sonarr? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              installsonarr
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

confirmcouchpotatoinstall ()
{
# Confirm with the user
read -r -p "   Confirm Installation of CouchPotato? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              installcouchpotato
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

confirmheadphonesinstall ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Headphones? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              installheadphones
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

confirmsonarrupdate ()
{
# Confirm with the user
read -r -p "   Confirm Update of Sonarr? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              updatesonarr
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

confirmcouchpotatoupdate ()
{
# Confirm with the user
read -r -p "   Confirm Update of CouchPotato? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              updatecouchpotato
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

confirmheadphonesupdate ()
{
# Confirm with the user
read -r -p "   Confirm Update of Headphones? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              updateheadphones
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


################################################################################
##### MAIN MENU
################################################################################

mainmenu=""

while [ "$choice" != "q,i" ]
do
        echo -e "${sep}"
        echo -e "${fin} Search Tools Script (CouchPotato / Sonarr / HeadPhones)${nc}"
        echo -e "${inf} Script Version: 1.0.1 (March 28, 2016)"
        echo " "
        echo -e "${msg} Main Menu"
        echo " "
        echo -e "${qry} Please make a selection!"
        echo " "
        echo -e "${fin}   1)${msg} Sonarr${nc}"
        echo -e "${fin}   2)${msg} CouchPotato${nc}"
        echo -e "${fin}   3)${msg} HeadPhones${nc}"
        echo " "
        echo -e "${inf}  i) Contact Me${nc}"
        echo -e "${alt}  q) Quit${nc}"
        echo -e "${sep}"

        read choice

        case $choice in
            '1')
                sonarrsubmenu
                ;;
            '2')
                couchpotatosubmenu
                ;;
            '3')
                headphonessubmenu
                ;;
            'i')
                contactme
                ;;
            'q') echo -e "${alt}        Exiting script!${nc}"
                echo " "
                ;;
            *)   echo -e "${emp}        Invalid choice, please try again${nc}"
                ;;
        esac
done

#!/bin/sh
# Script Version: 1.0.1 (March 31, 2016)
#	Install script for Calibre in a jailed environment
#   See http://forums.nas4free.org/viewtopic.php?f=79&t=7074 for more info.

# Modify to reflect the location of where you store all of your books.
CALIBRELIBRARYPATH="/mnt/Storage/Media/Books"

# Add some colour!
nc='\033[0m'        # No Color
alt='\033[0;31m'    # Alert Text
emp='\033[1;31m'    # Emphasis Text
msg='\033[1;37m'    # Message Text
url='\033[1;32m'    # URL
qry='\033[0;36m'    # Query Text
sep='\033[1;30m-------------------------------------------------------\033[0m'    # Line Seperator
cmd='\033[1;35m'    # Command to be entered

confirm ()
{
# Confirm with the user
read -r -p "   Continue? [Y/n] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              echo " "
              echo -e "${url} Great! Let's continue..${nc}"
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo -e "${emp} Stopping script..${nc}"
              echo " "
              exit
              ;;
esac
}

# define our bail out shortcut function anytime there is an error - display
# the error message, then exit returning 1.
exerr () { echo -e "$*" >&2 ; exit 1; }



echo -e "${sep}"
echo -e "${sep}     Welcome to the Calibre installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${sep} Let's get started with some packages${nc}"
echo -e "${sep}"
echo " "

pkg install -y nano calibre

# Configure /etc/rc.conf
echo 'calibre_enable="YES"' >> /etc/rc.conf
echo 'calibre_user="root"' >> /etc/rc.conf
echo 'calibre_library="${CALIBRELIBRARYPATH}"' >> /etc/rc.conf

echo " Modify this file to use root as the user"
echo "    : ${calibre_user:=root}"
continue
nano /usr/local/etc/rc.d/calibre

echo " Now restart this jail and calibre should be running"
echo " If you want to start it manually without restarting your jail"
echo 'calibre-server --with-library="${CALIBRELIBRARYPATH}"'

echo " "
echo -e "${sep}"
echo " That should be it!"
echo " Happy reading!!"
echo -e "${sep}"
echo " "

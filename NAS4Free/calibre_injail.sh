#!/bin/sh
# Script Version: TESTING-1.0 (March 10, 2016)
#	Install script for Calibre in a jailed environment
#   See http://forums.nas4free.org/viewtopic.php?f=79&t=7074 for more info.
#   Copyrighted 2016 by Ashley Townsend under the Beerware License.

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
              echo -e " \033[1;32mGreat! Let's continue..\033[0m"
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo -e " \033[1;31mBugger :( Stopping script..\033[0m"
              echo -e " \033[1;31mTry the NAS4Free forums if you need help.\033[0m"
              echo " "
              exit
              ;;
esac
}

# define our bail out shortcut function anytime there is an error - display
# the error message, then exit returning 1.
exerr () { echo -e "$*" >&2 ; exit 1; }



echo -e "${sep}"
echo -e "     \033[1;37mWelcome to the Calibre installer!\033[0m"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e " \033[1;37mLet's get started with some packages\033[0m"
echo -e "${sep}"
echo " "

pkg install -y nano calibre

# Configure /etc/rc.conf
echo 'calibre_enable="YES"' >> /etc/rc.conf
echo 'calibre_user="root"' >> /etc/rc.conf
echo 'calibre_library="/mnt/where/you/store/books"' >> /etc/rc.conf

echo " Modify this file to use root as the user"
echo "    : ${calibre_user:=root}"
continue
nano /usr/local/etc/rc.d/calibre

echo " Now restart this jail and calibre should be running"
echo " If you want to start it manually without restarting your jail"
echo calibre-server --with-library="/mnt/PATH_TO_YOUR_LIBRARY"

echo " "
echo -e "${sep}"
echo " That should be it!"
echo " Happy reading!!"
echo -e "${sep}"
echo " "

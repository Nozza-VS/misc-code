#!/bin/sh
# Script Version: TESTING-1.0 (March 10, 2016)
#	This is a simple script to automate the installation of a web server
#   within a jailed environment.
#   Copyrighted 2016 by Ashley Townsend under the Beerware License.

# TODO: Test in virtual machine



##### START CONFIGURATION #####

# Define which version of TheBrig to install - These 2 options MUST MATCH
# 1 = master   - For 9.0 and 9.1 FreeBSD versions
# 2 = working  - For 9.1 and 9.2 FreeBSD versions
# 3 = alcatraz - For 9.3 and 10.x FreeBSD versions
branch="alcatraz"
version="3"

# Define where to install TheBrig
installfolder="/mnt/Storage/System/Jails"

##### END CONFIGURATION #####

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
echo -e "   \033[1;31mIf TheBrig extension is showing, continue.\033[0m";
# Confirm with the user that TheBrig extension page is showing
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
              echo -e " \033[1;31mTry again or head to\033[0m"
              echo -e " \033[1;31mhttp://www.forums.nas4free.org/viewtopic.php?f=79&t=3894\033[0m"
              echo -e " \033[1;31mFor more information/support.\033[0m"
              echo " "
              exit
              ;;
esac
}

# define our bail out shortcut function anytime there is an error - display
# the error message, then exit returning 1.
exerr () { echo -e "$*" >&2 ; exit 1; }



echo -e "${sep}"
echo -e "     \033[1;37mWelcome to thebrig setup!\033[0m"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "     \033[1;37mGrab the install script\033[0m"
echo -e "${sep}"
echo " "

fetch https://raw.githubusercontent.com/fsbruva/thebrig/$branch/thebrig_install.sh

echo " "
echo -e "${sep}"
echo -e "     \033[1;37mRun install script\033[0m"
echo -e "${sep}"
echo " "

/bin/sh thebrig_install.sh $installfolder $version

echo " "
echo -e "${sep}"
echo -e "     \033[1;37mCheck to see if it is working\033[0m"
echo -e "${sep}"
echo " "

echo " Head to your nas webgui, check to see if 'Extensions > TheBrig' is there"
confirm

echo " "
echo -e "${sep}"
echo " That should be it!"
echo " Enjoy setting up your jails!"
echo -e "${sep}"
echo " "

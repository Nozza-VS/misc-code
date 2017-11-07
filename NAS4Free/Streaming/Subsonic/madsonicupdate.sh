#!/bin/sh
# AIO Script                    Version: 1.0.28 (January 15, 2017)
# By Ashley Townsend (Nozza)    Copyright: Beerware License
################################################################################
# While using "nano" to edit this script (nano /aioscript.sh),
# Use the up, down, left and right arrow keys to navigate. Once done editing,
# Press "X" while holding "Ctrl", Press "Y" then press "Enter" to save changes
################################################################################
##### START OF CONFIGURATION SECTION #####
#------------------------------------------------------------------------------#
###! SUBSONIC / MADSONIC CONFIG !###
subsonic_ver="6.0"          # You can find release numbers here:
                            # sourceforge.net/projects/subsonic/files/subsonic
madsonic_ver="6.2.9080"     # http://beta.madsonic.org/pages/download.jsp
#------------------------------------------------------------------------------#
##### END OF CONFIGURATION SECTION #####
################################################################################



#Grab the date & time to be used later
date=$(date +"%Y.%m.%d-%I.%M%p")

# Add some colour!
nc='\033[0m'        # Default Text (No Formatting / No Color)
alt='\033[0;31m'    # Alert Text
emp='\033[1;31m'    # Emphasis Text
msg='\033[1;37m'    # Message Text
url='\033[1;32m'    # URL
qry='\033[0;36m'    # Query Text
ssep='\033[1;30m#----------------------#\033[0m'    # Small Line Separator
msep='\033[1;30m#--------------------------------------#\033[0m'    # Medium Line Separator
sep='\033[1;30m----------------------------------------------------------------------\033[0m'   # Line Separator
cmd='\033[1;35m'    # Command to be entered
fin='\033[0;32m'    # Green Text
inf='\033[0;33m'    # Information Text
ul='\033[4m'        # Underline Text
lbt='\033[1;34m'    # Light Blue Text
yt='\033[1;33m'     # Yellow Text
lct='\033[1;36m'    # Light Cyan Text
ca='\033[1;30m'     # Currently Unavailable (Dark Grey Text)



#------------------------------------------------------------------------------#
### MADSONIC INSTALL

install.madsonic ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Welcome to the Madsonic installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's get started with some packages${nc}"
echo -e "${sep}"
echo " "

#pkg install -y madsonic-jetty
pkg install -y madsonic-standalone

echo " "
echo -e "${sep}"
echo " Adding madsonic to rc.conf"
echo -e "${sep}"
echo " "

echo 'madsonic_enable="YES"' >> /etc/rc.conf

echo " "
echo -e "${sep}"
echo -e "${msg} Now let's make sure madsonic starts.${nc}"
echo -e "${msg} You can manually do this with:${nc}"
echo -e "${cmd}    /usr/local/etc/madsonic start${nc}"
echo -e "${msg} For now, this script will do it automatically.${nc}"
echo -e "${sep}"
echo " "

/usr/local/etc/rc.d/madsonic start

echo " "
echo -e "${sep}"
echo -e "${msg} If madsonic started as it should you can connect to it via your${nc}"
echo -e "${msg} browser with following adress: Jail-IP:4040${nc}"
echo -e "${msg} Default username is admin, and password admin.${nc}"
echo -e "${sep}"
echo " "

echo " "
echo -e "${sep}"
echo " That should be it!"
echo " Enjoy your Subsonic server!"
echo -e "${sep}"
echo " "
}

#------------------------------------------------------------------------------#
### MADSONIC INSTALL

update.madsonic ()
{

}

#------------------------------------------------------------------------------#
### MADSONIC CONFIRM INSTALL

confirm.install.madsonic ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Madsonic? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.madsonic
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### MADSONIC CONFIRM UPDATE

confirm.update.madsonic ()
{
# Confirm with the user
read -r -p "   Confirm Update of Madsonic? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.madsonic
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

################################################################################
##### MAIN MENU
################################################################################

mainmenu=""

while [ "$choice" != "q,a,h,i,j" ]
do
        echo -e "${sep}"
        echo -e "${inf} Madsonic Script - Version: 1.0.0 (January 15, 2017) by Nozza"
        echo -e "${sep}"
        echo -e "${emp} Main Menu"
        echo " "
        echo -e "${qry} Please make a selection! ${nc}"
        echo " "
        echo -e "${fin}   1)${url} Install${nc}"
        echo -e "${fin}   2)${url} Update${nc}"
        echo -e "${fin}   3)${url} Backup${nc}"
        echo " "
        echo -e "${alt}   q) Quit${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1') echo -e "${inf} Installing..${nc}"
                echo " "
                confirm.install.madsonic
                ;;
            '2') echo -e "${inf} Running Update..${nc}"
                echo " "
                confirm.update.madsonic
                ;;
            '3') echo -e "${inf} Backup..${nc}"
                echo " "
                backup.madsonic
                ;;
            'q')
                echo -e "${alt}     Quitting, Bye!${nc}"
                echo  " "
                echo -e "${ssep}"
                exit
                ;;
            *)   echo -e "${alt}        Invalid choice, please try again${nc}"
                echo " "
                ;;
        esac
done

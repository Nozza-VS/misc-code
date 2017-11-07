#!/bin/sh
# Script Version: 1.0.0 (Feb 6, 2017)

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



#==============================================================================#
##### INFORMATION / ABOUT
#==============================================================================#

#------------------------------------------------------------------------------#
###

wipe.disk ()
{
# Confirm with the user
echo -e "${msg} PROCEED WITH CAUTION${nc}"
read -r -p "   Would you like to recompile these now? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              echo " "
              echo -e "${sep}"
              echo -e "${msg} First, lets do ImageMagick${nc}"
              echo -e "${msg} When the options pop up, disable (By pressing space when its highlighted):${nc}"
              echo -e "${inf}    16BIT_PIXEL   ${msg}(to increase thumbnail generation performance)${nc}"
              echo -e "${msg} and then press 'Enter'${nc}"
              echo " "

              recompile.imagemagick.continue

              cd /usr/ports/graphics/ImageMagick && make deinstall
              make clean && make clean-depends
              make config

              echo " "
              echo -e "${sep}"
              echo -e "${msg} Press 'OK'/'Enter' if any box that follows.${nc}"
              echo -e "${msg}    (There shouldn't be any that pop up)${nc}"
              echo -e "${sep}"
              echo " "

              recompile.imagemagick.continue

              make install clean
              #make -DBATCH install clean

              echo " "
              echo -e "${sep}"
              echo -e "${msg} Finished with the recompiling!${nc}"
              echo -e "${sep}"
              echo " "
              ;;
esac
}

echo "What disk do you want to wipe?"
echo "For example - ada1 :"
read disk
echo -e "${alt} OK, in 10 seconds all data on $disk will be destroyed!"
echo -e "${emp} Press CTRL+C to abort!"
sleep 10
diskinfo ${disk} | while read disk sectorsize size sectors other
do
        # Delete MBR, GPT Primary, ZFS(L0L1)/other partition table.
        /bin/dd if=/dev/zero of=/dev/${disk} bs=${sectorsize} count=8192
        # Delete GEOM metadata, GPT Secondary(L2L3).
        /bin/dd if=/dev/zero of=/dev/${disk} bs=${sectorsize} oseek=$(expr $sectors - 8192) count=8192
        # OR
        # /bin/dd if=/dev/zero of=/dev/${disk} bs=${sectorsize} oseek=`expr $sectors - 8192` count=8192
done

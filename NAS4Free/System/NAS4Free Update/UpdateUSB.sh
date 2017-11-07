#!/bin/sh

################################################################################

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

################################################################################

Path="${0%/*}"

setversion ()
{

echo " "
echo -e "${sep}"
echo -e "${msg} Which version number do you want?${nc}"
echo -e "${qry} Example version:${nc}"
echo -e "${url} 11.0.0.4${msg}.4249${nc}"
echo " "
echo " Version:"
read update_version
echo " "
echo " Version set to: ${update_version}"
echo " "
echo -e "${msg} Which revision number do you want?${nc}"
echo -e "${qry} Example revision:${nc}"
echo -e "${msg} 11.0.0.4.${url}4249${nc}"
echo " "
echo " Version:"
read update_revision
echo " "
echo " Revision set to: ${update_revision}"
echo " "
echo " Complete version set to: ${update_version}.${update_revision}"
echo " "
# is this right?

}

cleanup ()
{
echo " "
read -r -p "   Remove downloaded files? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              echo " "
              echo -e "${url} Cleaning up..${nc}"
			  echo " "
			  rm $Path/NAS4Free-*.img
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo -e "${alt}Skipping cleanup..${nc}"
              echo " "
              ;;
esac
}

echo " "
echo -e "${sep}"
echo -e "${msg} NAS4Free LiveUSB Update${nc}"
echo -e "${sep}"
echo " "
echo -e "${msg} You can find release numbers here:${nc}"
echo -e "${url} https://sourceforge.net/projects/nas4free/files/${nc}"
echo " "
echo -e "${sep}"
echo " "
echo -e "${msg} Make sure wget is installed${nc}"
echo -e "${sep}"
echo " "

pkg install wget

echo " "
echo -e "${sep}"
echo -e "${msg} Now set the version numbers to download${nc}"
echo -e "${sep}"
echo " "

setversion

echo -e "${sep}"
echo -e "${msg} Download the update${nc}"
echo -e "${sep}"
echo " "

wget https://sourceforge.net/projects/nas4free/files/NAS4Free-${update_version}/${update_version}.${update_revision}/NAS4Free-x64-LiveUSB-${update_version}.${update_revision}.img.gz -P $Path

echo " "
echo -e "${sep}"
echo -e "${msg} Now to extract the download${nc}"
echo -e "${sep}"
echo " "

gunzip $Path/NAS4Free-x64-LiveUSB-${update_version}.${update_revision}.img.gz

echo " "
echo -e "${sep}"
echo -e "${msg} Download done, let's update the USB${nc}"
echo -e "${sep}"
echo " "

cat /mnt/System/Updates/NAS4Free-x64-LiveUSB-${update_version}.${update_revision}.img | pv -s 971M | dd of=/dev/da0 bs=16k
	
echo " "
echo -e "${sep}"
echo -e "${msg} Done, now boot to USB and update the server${nc}"
echo -e "${sep}"
echo " "

cleanup

# ask for shutdown
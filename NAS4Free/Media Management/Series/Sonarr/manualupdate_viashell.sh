#!/bin/sh
# TODO: Merge with AIO script
# Sonarr manual update script
# Version 1.02 (March 15, 2016)
# This is for installations that followed the documented FreeBSD installation
# You can find this information here: https://github.com/Sonarr/Sonarr/wiki/FreeBSD-installation
# This can be used temporarily for when Built-In update mechanism fails or in place of it enitrely.

# ONLY RUN VIA SHELL!

#Grab the date & time to be used later
backupdate=$(date +"%Y.%m.%d-%I.%M%p")

sep='\033[1;30m-------------------------------------------------------\033[0m'    # Line Seperator

echo " "
echo -e "${sep}"
echo "   Sonarr Manual Update Script"
echo -e "${sep}"
echo " "

echo " "
echo -e "${sep}"
echo "   Let's start with downloading the update"
echo -e "${sep}"
echo " "

cd /tmp
fetch http://download.sonarr.tv/v2/master/mono/NzbDrone.master.tar.gz

echo " "
echo " " 
echo -e "${sep}"
echo "   Deleting any old updates & extracting files"
echo -e "${sep}"
echo " "

rm -r /tmp/sonarr_update
tar xvfz NzbDrone.master.tar.gz
mv /tmp/NzbDrone /tmp/sonarr_update

echo " "
echo " " 
echo -e "${sep}"
echo "   Shutting down Sonarr"
echo -e "${sep}"
echo " "

service sonarr stop

echo " "
echo " " 
echo -e "${sep}"
echo "   Backing up config and database"
echo -e "${sep}"
echo " "

mkdir /tmp/sonarr_backup
cp /usr/local/sonarr/nzbdrone.db /tmp/sonarr_backup/nzbdrone.db-${backupdate}
cp /usr/local/sonarr/config.xml /tmp/sonarr_backup/config.xml-${backupdate}

echo " "
echo " " 
echo -e "${sep}"
echo "   Renaming old sonarr folder & copying new"
echo "   Setting permissions while we are at it"
echo -e "${sep}"
echo " "

mv /usr/local/share/sonarr /usr/local/share/sonarr.manualupdate-${backupdate}
cp -r /tmp/sonarr_update /usr/local/share/sonarr
chown -R 351:0 /usr/local/share/sonarr/
chmod -R 755 /usr/local/share/sonarr/

echo " "
echo " " 
echo -e "${sep}"
echo "   Last second housecleaning"
echo -e "${sep}"
echo " "

rm /tmp/NzbDrone.master.tar.gz

echo " "
echo " " 
echo -e "${sep}"
echo "   Starting up Sonarr"
echo -e "${sep}"
echo " "

service sonarr start

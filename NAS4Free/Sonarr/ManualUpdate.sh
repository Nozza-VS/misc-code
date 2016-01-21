#!/bin/sh

# Sonarr manual update script
# This is for installations that followed the documented FreeBSD installation
# You can find this information here: https://github.com/Sonarr/Sonarr/wiki/FreeBSD-installation
# This can be used temporarily for when Built-In update mechanism fails or in place of it enitrely.

#Grab the date & time to be used later
backupdate=$(date +"%Y.%m.%d-%I.%M%p")

echo " "
echo "################################################" 
echo "#   Sonarr Manual Update Script"
echo "################################################ "
echo " "

echo " "
echo "################################################" 
echo "#   Let's start with downloading the update"
echo "################################################ "
echo " "

cd /tmp
fetch http://download.sonarr.tv/v2/master/mono/NzbDrone.master.tar.gz

echo " "
echo " " 
echo "################################################" 
echo "#   Deleting any old updates & extracting files"
echo "################################################ "
echo " "

rm -r /tmp/sonarr_update
tar xvfz NzbDrone.master.tar.gz
mv /tmp/NzbDrone /tmp/sonarr_update

echo " "
echo " " 
echo "################################################" 
echo "#   Shutting down Sonarr"
echo "################################################ "
echo " "

service sonarr stop

echo " "
echo " " 
echo "################################################" 
echo "#   Backing up config and database"
echo "################################################ "
echo " "

mkdir /tmp/sonarr_backup
cp /usr/local/sonarr/nzbdrone.db /tmp/sonarr_backup/nzbdrone.db-${backupdate}
cp /usr/local/sonarr/config.xml /tmp/sonarr_backup/config.xml-${backupdate}

echo " "
echo " " 
echo "################################################" 
echo "#   Renaming old sonarr folder & copying new"
echo "#   Setting permissions while we are at it"
echo "################################################ "
echo " "

mv /usr/local/share/sonarr /usr/local/share/sonarr.manualupdate-${backupdate}
cp -r /tmp/sonarr_update /usr/local/share/sonarr
chown -R 351:0 /usr/local/share/sonarr/
chmod -R 755 /usr/local/share/sonarr/

echo " "
echo " " 
echo "################################################" 
echo "#   Last second housecleaning"
echo "################################################ "
echo " "

rm /tmp/NzbDrone.master.tar.gz

echo " "
echo " " 
echo "################################################" 
echo "#   Starting up Sonarr"
echo "################################################ "
echo " "

service sonarr start
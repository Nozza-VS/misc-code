#!/bin/sh

# Sonarr manual update script
# This is for my own installation method. If you used the FreeBSD install insctructions, see the other update script.
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

cp /usr/local/sonarr/nzbdrone.db /data/Sonarr/Backup/nzbdrone.db-${backupdate}
cp /usr/local/sonarr/config.xml /data/Sonarr/Backup/config.xml-${backupdate}

echo " "
echo " " 
echo "################################################" 
echo "#   Renaming old sonarr folder & copying new"
echo "#   Setting permissions while we are at it"
echo "################################################ "
echo " "

mv /data/Sonarr/App /data/Sonarr/Backup/manualupdate-${backupdate}
cp -r /tmp/sonarr_update /data/Sonarr/App
chmod -R 775 /data/Sonarr/App/

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
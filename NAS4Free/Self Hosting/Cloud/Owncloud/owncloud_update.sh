#!/bin/sh
# Script Version: 1.03 (February 8, 2016)
###########################################################################
#     This is a simple script to automate the update of Owncloud within a 
#     jailed environment. This is not garunteed to work on all systems and was
#     made specifically to update an owncloud installation based off this how-to:
#     http://forums.nas4free.org/viewtopic.php?f=79&t=9383
#     You should not have any reason to use this unless the built-in updater app fails.
#     Made by Nostalgist92. Use carefully, I am not responsible for any loss of data.
###########################################################################



##### START CONFIGURATION #####
# If you want a specific version of owncloud change 'latest' to the version you want. 
# Example: owncloud_version="8.2.2"
# Otherwise, leave this as is to get the latest version.

owncloud_version="latest"

### No need to edit below here ###
##### END OF CONFIGURATION SECTION #####



# Grab the date & time to be used later
backupdate=$(date +"%Y.%m.%d-%I.%M%p")

confirm () 
{
# Alert the user what they are about to do.
echo -e "${emp}   About to run the update script${nc}";
# Confirm with the user
read -r -p "   Are you completely sure you wish to continue? [Y/n] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
              # If yes, then execute the passed parameters
              echo " "
              echo -e "${url} Ok, let's get to updating!${nc}"
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo -e "${alt} Stopping script..${nc}"
              echo " "
              exit
              ;;
esac
}

# Add some colour!
nc='\033[0m'        # No Color
alt='\033[0;31m'    # Alert Text
emp='\033[1;31m'    # Emphasis Text
msg='\033[1;37m'    # Message Text
url='\033[1;32m'    # URL
qry='\033[0;36m'    # Query Text
sep='\033[1;30m-------------------------------------------------------\033[0m'    # Line Seperator
cmd='\033[1;35m'    # Command to be entered



# define our bail out shortcut function anytime there is an error - display 
# the error message, then exit returning 1.
exerr () { echo -e "$*" >&2 ; exit 1; }



echo " "
echo -e "${sep}" 
echo -e "${msg}     Welcome to the OwnCloud Updater!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo -e "${alt} You should only be using this script if the built-in updater fails.${nc}"
echo -e "${msg} Also note that this won't remove any old backups so the backup folder may get${nc}"
echo -e "${msg} very large depending on your /data, it's up to you to clean it up if you wish.${nc}"
echo " " 
confirm
echo " "
echo -e "${sep}" 
echo -e "${msg}     Let's start with downloading the update.${nc}"
echo -e "${sep}"
echo " "

cd "/tmp"
fetch "https://download.owncloud.org/community/owncloud-${owncloud_version}.tar.bz2"

echo " "
echo -e "${sep}" 
echo -e "${msg}     Stop the web server until the update is done.${nc}"
echo -e "${sep}"
echo " "

/usr/local/etc/rc.d/lighttpd stop

echo " "
echo -e "${sep}" 
echo -e "${msg}     Create backup.${nc}"
echo -e "${sep}"
echo " "

# Create inital backup folder if it doesn't exist
mkdir -p /usr/local/www/.owncloud-backup

# Copy current install to backup directory
# mv /usr/local/www/owncloud  /usr/local/www/.owncloud-backup/owncloud-${backupdate} # NOTE: May not need this but leaving it in just in case
cp -R /usr/local/www/owncloud  /usr/local/www/.owncloud-backup/owncloud-${backupdate}

echo -e "${msg} Backup of current install made in:${nc}"
echo -e "${qry}     /usr/local/www/.owncloud-backup/owncloud-${nc}\033[1;36m${backupdate}${nc}"
echo -e "${msg} Keep note of this just in case something goes wrong with the update${nc}"

echo " "
echo -e "${sep}" 
echo -e "${msg}     Now to extract OwnCloud in place of the old install.${nc}"
echo -e "${sep}"
echo " "

tar xf "owncloud-${owncloud_version}.tar.bz2" -C /usr/local/www
echo " Done!"
# Give permissions to www
chown -R www:www /usr/local/www/

#echo " " # NOTE: May not need the next few lines but leaving them in just in case
#echo -e "${sep}" 
#echo -e "${msg}     Restore owncloud config, /data & /themes${nc}"
#echo -e "${sep}"
#echo " "

# cp -R /usr/local/www/.owncloud-backup/owncloud-${backupdate}/data /usr/local/www/owncloud/
# cp -R /usr/local/www/.owncloud-backup/owncloud-${backupdate}/themes/* /usr/local/www/owncloud/
# cp /usr/local/www/.owncloud-backup/owncloud-${backupdate}/config/config.php /usr/local/www/owncloud/config/

echo " " 
echo -e "${sep}" 
echo -e "${msg}     Starting the web server back up${nc}"
echo -e "${sep}"
echo " "

/usr/local/etc/rc.d/lighttpd start

echo " " 
echo -e "${sep}" 
echo -e "${msg} That should be it!${nc}"
echo -e "${msg} Now head to your OwnCloud webpage and make sure everything is working correctly.${nc}"
echo " "
echo -e "${msg} If something went wrong you can do the following to restore the old install:${nc}"
echo -e "${cmd}   rm -r /usr/local/www/owncloud${nc}"
echo -e "${cmd}   mv /usr/local/www/.owncloud-backup/owncloud-${backupdate} /usr/local/www/owncloud${nc}"
echo " "
echo -e "${msg} After you check to make sure everything is working fine as expected,${nc}"
echo -e "${msg} You can safely remove backups with this command (May take some time):${nc}"
echo -e "${cmd}   rm -r /usr/local/www/.owncloud-backup${nc}"
echo -e "${alt} THIS WILL REMOVE ANY AND ALL BACKUPS MADE BY THIS SCRIPT${nc}"
echo " "
echo -e "${sep}"
echo " "
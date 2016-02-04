#!/bin/sh

# Grab the date & time to be used later
backupdate=$(date +"%Y.%m.%d-%I.%M%p")

confirm () 
{
# Alert the user what they are about to do.
echo -e "   \033[1;31mAbout to $@run the update script\033[0m";
# Confirm with the user
read -r -p "   Are you completely sure you wish to continue? [Y/n] " response
case "$response" in
    [yY][eE][sS]|[yY]) 
              # If yes, then execute the passed parameters
               "$@"
              echo " "
              echo -e " \033[1;32mOk, let's get to updating!\033[0m"
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo -e " \033[1;31mStopping script..\033[0m"
              echo " "
              exit
              ;;
esac
}

##### START CONFIGURATION #####

# If you want a specific version of owncloud change 'latest' to the version you want. 
# Example: owncloud_version="8.2.2"
# Otherwise, leave this as is to get the latest version.
owncloud_version="latest"

##### END CONFIGURATION #####

#     This is a simple script to automate the update of Owncloud within a 
#     jailed environment. This is not garunteed to work on all systems and was
#     made specifically to update an owncloud installation based off this how-to:
#     http://forums.nas4free.org/viewtopic.php?f=79&t=9383
#     You should not have any reason to use this unless the built-in updater app fails.
#     Made by Nostalgist92. Use carefully, I am not responsible for any loss of data.

# define our bail out shortcut function anytime there is an error - display 
# the error message, then exit returning 1.
exerr () { echo -e "$*" >&2 ; exit 1; }



echo " "
echo -e "\033[1;30m##################################################\033[0m" 
echo -e "     \033[1;37mWelcome to the OwnCloud Updater!\033[0m"
echo -e "\033[1;30m################################################## \033[0m"
echo " "
echo " "
echo -e " \033[0;31mYou should only be using this script if the built-in updater fails.\033[0m"
echo " Also note that this won't remove any old backups so the backup folder may get"
echo " very large depending on your /data, it's up to you to clean it up if you wish."
echo " " 
confirm
echo " "
echo -e "\033[1;30m##################################################\033[0m" 
echo -e "     \033[1;37mLet's start with moving the current install.\033[0m"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

# Create inital backup folder if it doesn't exist
mkdir -p /usr/local/www/.owncloud-backup

# Move current install to backup directory
mv /usr/local/www/owncloud  /usr/local/www/.owncloud-backup/owncloud-${backupdate}/
echo " Moved current install to:"
echo -e "     \033[0;36m/usr/local/www/.owncloud-backup/owncloud-\033[0m\033[1;36m${backupdate}\033[0m"
echo " Keep note of this just in case something goes wrong with the update"

echo " "
echo -e "\033[1;30m##################################################\033[0m" 
echo -e "     \033[1;37mNow to Download & Extract OwnCloud.\033[0m"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

cd "/tmp"
fetch "https://download.owncloud.org/community/owncloud-${owncloud_version}.tar.bz2"
tar xf "owncloud-${owncloud_version}.tar.bz2" -C /usr/local/www
echo " Done"
# Give permissions to www
chown -R www:www /usr/local/www/

echo " " 
echo -e "\033[1;30m##################################################\033[0m" 
echo -e "     \033[1;37mRestore owncloud config, /data & /themes\033[0m"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

cp -R /usr/local/www/.owncloud-backup/owncloud-${backupdate}/data /usr/local/www/owncloud/
cp -R /usr/local/www/.owncloud-backup/owncloud-${backupdate}/themes/* /usr/local/www/owncloud/
cp /usr/local/www/.owncloud-backup/owncloud-${backupdate}/config/config.php /usr/local/www/owncloud/config/


echo " " 
echo -e "\033[1;30m##################################################\033[0m" 
echo " That should be it!"
echo " Now head to your OwnCloud webpage and make sure everything is working correctly."
echo " "
echo " If something went wrong you can do the following to restore the old install:"
echo -e "\033[1;35m   rm -r /usr/local/www/owncloud\033[0m"
echo -e "\033[1;35m   mv /usr/local/www/.owncloud-backup/owncloud-${backupdate} /usr/local/www/owncloud\033[0m"
echo " "
echo " After you check to make sure everything is working fine as expected,"
echo " You can safely remove backups with this command (May take some time):"
echo -e "\033[1;35m   rm -r /usr/local/www/.owncloud-backup\033[0m"
echo -e " \033[0;31mTHIS WILL REMOVE ANY AND ALL BACKUPS MADE BY THIS SCRIPT\033[0m"
echo " "
echo -e "\033[1;30m################################################## \033[0m"
echo " "
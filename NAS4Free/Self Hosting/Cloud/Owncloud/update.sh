#------------------------------------------------------------------------------#
### OWNCLOUD CONFIRM UPDATE

confirm.update.owncloud ()
{
# Confirm with the user
echo -e "${emp} NOTE: ${msg}OwnCloud should be able to handle it's own updates automatically${nc}"
echo -e "${msg}       This updater should only be used if the built-in one fails${nc}"
echo " "
echo -e "${msg} Also note that this won't remove any old backups so the backup folder may get${nc}"
echo -e "${msg} very large depending on your /data, it's up to you to clean it up if you wish.${nc}"
echo " "
echo -e "${msg} One last thing to note is you need to modify the .${nc}"
echo " "
read -r -p "   Confirm Update of OwnCloud? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.owncloud
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### OWNCLOUD UPDATE

update.owncloud ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}     Welcome to the OwnCloud Updater!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}     Let's start with downloading the update.${nc}"
echo -e "${sep}"
echo " "

cd "/tmp"
fetch "https://download.owncloud.org/community/owncloud-${owncloud_update}.tar.bz2"

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
# mv /usr/local/www/owncloud  /usr/local/www/.owncloud-backup/owncloud-${date} # NOTE: May not need this but leaving it in just in case
cp -R /usr/local/www/owncloud  /usr/local/www/.owncloud-backup/owncloud-${date}

echo -e "${msg} Backup of current install made in:${nc}"
echo -e "${qry}     /usr/local/www/.owncloud-backup/owncloud-${nc}\033[1;36m${date}${nc}"
echo -e "${msg} Keep note of this just in case something goes wrong with the update${nc}"

echo " "
echo -e "${sep}"
echo -e "${msg}     Now to extract OwnCloud in place of the old install.${nc}"
echo -e "${sep}"
echo " "

tar xf "owncloud-${owncloud_update}.tar.bz2" -C /usr/local/www
echo " Done!"
# Give permissions to www
chown -R www:www /usr/local/www/

#echo " " # NOTE: May not need the next few lines but leaving them in just in case
#echo -e "${sep}"
#echo -e "${msg}     Restore owncloud config, /data & /themes${nc}"
#echo -e "${sep}"
#echo " "

# cp -R /usr/local/www/.owncloud-backup/owncloud-${date}/data /usr/local/www/owncloud/
# cp -R /usr/local/www/.owncloud-backup/owncloud-${date}/themes/* /usr/local/www/owncloud/
# cp /usr/local/www/.owncloud-backup/owncloud-${date}/config/config.php /usr/local/www/owncloud/config/

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
echo -e "${cmd}   mv /usr/local/www/.owncloud-backup/owncloud-${date} /usr/local/www/owncloud${nc}"
echo " "
echo -e "${msg} After you check to make sure everything is working fine as expected,${nc}"
echo -e "${msg} You can safely remove backups with this command (May take some time):${nc}"
echo -e "${cmd}   rm -r /usr/local/www/.owncloud-backup${nc}"
echo -e "${alt} THIS WILL REMOVE ANY AND ALL BACKUPS MADE BY THIS SCRIPT${nc}"
echo " "
echo -e "${sep}"
echo " "

}

confirm.update.owncloud
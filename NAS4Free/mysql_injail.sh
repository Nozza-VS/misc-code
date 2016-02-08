#!/bin/sh
#	This is a simple script to automate the installation of a mysql server
#   within a jailed environment.
#   Copyrighted 2016 by Ashley Townsend under the Beerware License.

##### START CONFIGURATION #####

# If you want a specific version of owncloud change 'latest' to the version you want.
# Example: owncloud_version="8.2.2"
# Otherwise, leave this as is to get the latest version.
phpmyadmin_version="4.5.4.1"
mysql_password="mysqlpassword"

##### END CONFIGURATION #####

confirm ()
{
# Confirm with the user
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
              echo -e " \033[1;31mBugger :( Stopping script..\033[0m"
              echo -e " \033[1;31mTry the NAS4Free forums if you need help.\033[0m"
              echo " "
              exit
              ;;
esac
}

# define our bail out shortcut function anytime there is an error - display
# the error message, then exit returning 1.
exerr () { echo -e "$*" >&2 ; exit 1; }



echo -e "\033[1;30m##################################################\033[0m"
echo -e "     \033[1;37mWelcome to the MySQL & phpMyAdmin setup!\033[0m"
echo -e "\033[1;30m################################################## \033[0m"
echo " "
echo " "
echo " "
echo -e "\033[1;30m##################################################\033[0m"
echo -e "     \033[1;37mLet's get started with some packages\033[0m"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

# Install packages
pkg install -y mysql56-server php56 php56-extensions php56-xmlrpc php56-gettext php56-mcrypt php56-mysql php56-mysqli php56-mbstring

echo " "
echo -e "\033[1;30m##################################################\033[0m"
echo "Packages installed - now configuring mySQL"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

# cd /usr/local
# mysql_install_db
echo 'mysql_enable="YES"' >> /etc/rc.conf
echo '[mysqld]' >> /var/db/mysql/my.cnf
echo 'skip-networking' >> /var/db/mysql/my.cnf

/usr/local/etc/rc.d/mysql-server start

echo " "
echo -e "\033[1;30m##################################################\033[0m"
echo "Getting ready to secure the install. The root password is blank, "
echo "and you want to provide a strong root password, remove the anonymous accounts"
echo "disallow remote root access, remove the test database, and reload privilege tables"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

# /usr/local/bin/mysqladmin -u root -h localhost password '$mysqlpassword'
mysql_secure_installation

echo " "
echo -e "\033[1;30m##################################################\033[0m"
echo -e "     \033[1;37mMySQL done, now to phpMyAdmin\033[0m"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

# Copy sample config file which will set php to default settings
cp /usr/local/etc/php.ini-development /usr/local/etc/php.ini

# Create directory for phpMyAdmin to live in
mkdir -p /usr/local/phpMyAdmin/downloads
cd /usr/local/phpMyAdmin/downloads

# Download phpMyAdmin
fetch http://files.phpmyadmin.net/phpMyAdmin/$phpmyadmin_version/phpMyAdmin-$phpmyadmin_version-all-languages.tar.gz
tar -zxvf phpMyAdmin-$phpmyadmin_version-all-languages.tar.gz
mv phpMyAdmin-$phpmyadmin_version-all-languages/* /usr/local/phpMyAdmin

# Link phpMyAdmin to www folder
ln -s /usr/local/phpMyAdmin/ /usr/local/www/phpMyAdmin

# Check with user to see if it is working
echo "   You should be able to view phpMyAdmin at http://yourjailsip/phpMyAdmin/"
echo "   If you can't you may need to get some support"
echo " "
echo " Answer yes if you can view the page, no if you are unable to."
confirm

echo " "
echo -e "\033[1;30m##################################################\033[0m"
echo " That should be it!"
echo " Enjoy your MySQL server with phpMyAdmin web access!"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

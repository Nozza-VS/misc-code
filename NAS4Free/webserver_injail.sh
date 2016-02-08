#!/bin/sh
#	This is a simple script to semi-automate the installation of a web server
#   within a jailed environment.
#   Copyrighted 2016 by Ashley Townsend under the Beerware License.

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
echo -e "     \033[1;37mWelcome to the MySQL / phpMyAdmin / Apache web server setup!\033[0m"
echo -e "\033[1;30m################################################## \033[0m"
echo " "
echo " "
echo " "
echo -e "\033[1;30m##################################################\033[0m"
echo -e "     \033[1;37mLet's get started with some packages\033[0m"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

# Install packages
pkg install -y mysql56-server phpmyadmin mod_php56 php56-extensions php56-mysql php56-mysqli apache24

echo " "
echo -e "\033[1;30m##################################################\033[0m"
echo "Packages installed - now configuring mySQL"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

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

mysql_secure_installation

echo " "
echo -e "\033[1;30m##################################################\033[0m"
echo -e "     \033[1;37mMySQL done, now to apache\033[0m"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

echo 'apache24_enable="YES"' >> /etc/rc.conf
/usr/local/etc/rc.d/apache24 start

# Confirm apache is working
echo -e " \033[1;31mHead to your jail ip, blah blah blah\033[0m"
confirm

# Copy sample config file which will set php to default settings
cp /usr/local/etc/php.ini-development /usr/local/etc/php.ini

# Configure apache: /usr/local/etc/apache24/httpd.conf
# Modify this line: DirectoryIndex index.html
# To show as: DirectoryIndex index.html index.php
# Restart apache to update changes
service apache24 restart

echo " "
echo -e "\033[1;30m##################################################\033[0m"
echo -e "     \033[1;37mApache setup done, now to phpmyadmin\033[0m"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

# Create basic config & make it writable
mkdir /usr/local/www/phpMyAdmin/config && chmod o+w /usr/local/www/phpMyAdmin/config
chmod o+r /usr/local/www/phpMyAdmin/config.inc.php
echo -e " \033[1;31mHead to http://your-hostname-or-IP-address/phpmyadmin/setup, do stuff there\033[0m"
confirm

# Move configuration file up one directory so phpmyadmin can make use of it
mv /usr/local/www/phpMyAdmin/config/config.inc.php /usr/local/www/phpMyAdmin
echo -e " \033[1;31mDouble check before proceeding\033[0m"
confirm

# Everything should be working so deleting config directory
rm -r /usr/local/www/phpMyAdmin/config

# Secure permissions of config file
chmod o-r /usr/local/www/phpMyAdmin/config.inc.php

# Restart Apache & MySQL servers
service apache24 restart
service mysql-server restart

echo " "
echo -e "\033[1;30m##################################################\033[0m"
echo " That should be it!"
echo " Enjoy your MySQL server!"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

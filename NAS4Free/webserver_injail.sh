#!/bin/sh
# Script Version: TESTING-1.0 (March 10, 2016)
#	This is a simple script to semi-automate the installation of a web server
#   within a jailed environment.
#   Copyrighted 2016 by Ashley Townsend under the Beerware License.

# Add some colour!
nc='\033[0m'        # No Color
alt='\033[0;31m'    # Alert Text
emp='\033[1;31m'    # Emphasis Text
msg='\033[1;37m'    # Message Text
url='\033[1;32m'    # URL
qry='\033[0;36m'    # Query Text
sep='\033[1;30m-------------------------------------------------------\033[0m'    # Line Seperator
cmd='\033[1;35m'    # Command to be entered

confirm ()
{
# Confirm with the user
read -r -p "   Continue? [Y/n] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              echo " "
              echo -e "${url} Great! Let's continue..${nc}"
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo -e "${emp} Bugger :( Stopping script..${nc}"
              echo -e "${emp} Try the NAS4Free forums if you need help.${nc}"
              echo " "
              exit
              ;;
esac
}

# define our bail out shortcut function anytime there is an error - display
# the error message, then exit returning 1.
exerr () { echo -e "$*" >&2 ; exit 1; }



echo " "
echo -e "${sep}"
echo -e "${msg}   Welcome to the MySQL / phpMyAdmin / Apache web server setup!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's get started with some packages${nc}"
echo -e "${sep}"
echo " "

# Install packages
pkg install -y mysql56-server phpmyadmin mod_php56 php56-extensions php56-mysql php56-mysqli apache24

echo " "
echo -e "${sep}"
echo "Packages installed - now configuring mySQL"
echo -e "${sep}"
echo " "

echo 'mysql_enable="YES"' >> /etc/rc.conf
echo '[mysqld]' >> /var/db/mysql/my.cnf
echo 'skip-networking' >> /var/db/mysql/my.cnf

/usr/local/etc/rc.d/mysql-server start

echo " "
echo -e "${sep}"
echo "Getting ready to secure the install. The root password is blank, "
echo "and you want to provide a strong root password, remove the anonymous accounts"
echo "disallow remote root access, remove the test database, and reload privilege tables"
echo -e "${sep}"
echo " "

mysql_secure_installation

echo " "
echo -e "${sep}"
echo -e "${msg}     MySQL done, now to apache${nc}"
echo -e "${sep}"
echo " "

echo 'apache24_enable="YES"' >> /etc/rc.conf
/usr/local/etc/rc.d/apache24 start

# Confirm apache is working
echo -e "${emp} Head to your jail ip, blah blah blah${nc}"
confirm

# Copy sample config file which will set php to default settings
cp /usr/local/etc/php.ini-development /usr/local/etc/php.ini

# Configure apache: /usr/local/etc/apache24/httpd.conf
# Modify this line: DirectoryIndex index.html
# To show as: DirectoryIndex index.html index.php
# Restart apache to update changes
service apache24 restart

echo " "
echo -e "${sep}"
echo -e "${msg}     Apache setup done, now to phpmyadmin${nc}"
echo -e "${sep}"
echo " "

# Create basic config & make it writable
mkdir /usr/local/www/phpMyAdmin/config && chmod o+w /usr/local/www/phpMyAdmin/config
chmod o+r /usr/local/www/phpMyAdmin/config.inc.php
echo -e "${emp} Head to http://your-hostname-or-IP-address/phpmyadmin/setup, do stuff there${nc}"
confirm

# Move configuration file up one directory so phpmyadmin can make use of it
mv /usr/local/www/phpMyAdmin/config/config.inc.php /usr/local/www/phpMyAdmin
echo -e "${emp} Double check before proceeding${nc}"
confirm

# Everything should be working so deleting config directory
rm -r /usr/local/www/phpMyAdmin/config

# Secure permissions of config file
chmod o-r /usr/local/www/phpMyAdmin/config.inc.php

# Restart Apache & MySQL servers
service apache24 restart
service mysql-server restart

echo " "
echo -e "${sep}"
echo " That should be it!"
echo " Enjoy your MySQL server!"
echo -e "${sep}"
echo " "

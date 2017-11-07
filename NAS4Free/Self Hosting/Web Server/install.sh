#------------------------------------------------------------------------------#
### WEB SERVER CONFIRM INSTALL

confirm.install.webserver ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Web Server? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.webserver
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### WEB SERVER INSTALL

install.webserver ()
{
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
pkg install -y mysql56-server phpmyadmin mod_php56 php56-extensions php56-mysql php56-mysqli apache24 nano imagemagick

echo " "
echo -e "${sep}"
echo "Packages installed - now configuring mySQL"
echo -e "${sep}"
echo " "

echo 'mysql_enable="YES"' >> /etc/rc.conf
echo '[mysqld]' >> /var/db/mysql/my.cnf
echo 'skip-networking' >> /var/db/mysql/my.cnf

service mysql-server start
#/usr/local/etc/rc.d/mysql-server start

echo " "
echo -e "${sep}"
echo "Getting ready to secure the install. The root password is blank, "
echo "and you want to provide a strong root password, remove the anonymous accounts"
echo "disallow remote root access, remove the test database, and reload privilege tables"
echo -e "${sep}"
echo " "

mysql_secure_installation
# OR (Less Secure)
# /usr/local/bin/mysqladmin -u root password 'your-password'

echo " "
echo -e "${sep}"
echo -e "${msg}     MySQL done, now to apache${nc}"
echo -e "${sep}"
echo " "

echo 'apache24_enable="YES"' >> /etc/rc.conf
service apache24 start
#/usr/local/etc/rc.d/apache24 start

# Confirm apache is working
echo -e "${emp} Head to your jail ip, blah blah blah${nc}"
confirm

# Copy sample config file which will set php to default settings
cp /usr/local/etc/php.ini-development /usr/local/etc/php.ini

# Configure apache: /usr/local/etc/apache24/httpd.conf
# Modify this line: DirectoryIndex index.html (Line 278)
# To show as: DirectoryIndex index.html index.php
# Restart apache to update changes

# Also add these lines:
#<FilesMatch "\.php$">
#    SetHandler application/x-httpd-php
#</FilesMatch>
#<FilesMatch "\.phps$">
#    SetHandler application/x-httpd-php-source
#</FilesMatch>
#
#Alias /phpmyadmin "/usr/local/www/phpMyAdmin"
#
#<Directory "/usr/local/www/phpMyAdmin">
#Options None
#AllowOverride None
#Require all granted
#</Directory>

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
echo " Enjoy your Web server!"
echo -e "${sep}"
echo " "
}

confirm.install.webserver
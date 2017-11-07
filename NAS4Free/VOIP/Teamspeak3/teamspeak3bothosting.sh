#------------------------------------------------------------------------------#
### TEAMSPEAK 3 SERVER BOT HOSTING EDITION INSTALL

install.teamspeak3bothosting ()
{

# Update the pkg management system first
pkg update
pkg upgrade

# Install packages, may not need ALL of these but grabbing them anyway
pkg install -y openjdk8 wget apache24 phpmyadmin mysql56-server php56-mysql php56-mysqli mod_php56 php56-extensions php56-sockets php56-session

echo " "
echo -e "${sep}"
echo -e "${msg} Packages installed - now configuring MySQL${nc}"
echo -e "${sep}"
echo " "

echo 'mysql_enable="YES"' >> /etc/rc.conf
echo '[mysqld]' >> /var/db/mysql/my.cnf
echo 'skip-networking' >> /var/db/mysql/my.cnf

# Start MySQL Server
/usr/local/etc/rc.d/mysql-server start

echo " "
echo -e "${sep}"
echo -e "${msg} Securing the install. Default root password is blank,${nc}"
echo -e "${msg} you want to provide a strong root password, remove the${nc}"
echo -e "${msg} anonymous accounts, disallow remote root access,${nc}"
echo -e "${msg} remove the test database, and reload privilege tables${nc}"
echo -e "${sep}"
echo " "

mysql_secure_installation

# Copy php ini
cp /usr/local/etc/php.ini-development /usr/local/etc/php.ini

# Enable apache server at startup
echo 'apache24_enable="YES"' >> /etc/rc.conf

# Modify web server
# First, we will configure Apache to load index.php files by default by adding the following lines:
# Configure apache: /usr/local/etc/apache24/httpd.conf
# Modify this line: DirectoryIndex index.html (Line 278)
# To show as: DirectoryIndex index.html index.php
# Restart apache to update changes

# Next, we will configure Apache to process requested PHP files with the PHP processor.
echo '<FilesMatch "\.php$">' >> /usr/local/etc/apache24/httpd.conf
echo '    SetHandler application/x-httpd-php' >> /usr/local/etc/apache24/httpd.conf
echo '</FilesMatch>' >> /usr/local/etc/apache24/httpd.conf
echo '<FilesMatch "\.phps$">' >> /usr/local/etc/apache24/httpd.conf
echo '    SetHandler application/x-httpd-php-source' >> /usr/local/etc/apache24/httpd.conf
echo '</FilesMatch>' >> /usr/local/etc/apache24/httpd.conf

# Start web server
service apache24 start

# Download server bot
wget -r -l1 -np -A "JTS3ServerMod_HostingEdition_*.zip" http://www.stefan1200.de/downloads/ -O /tmp/JTS3ServerMod_HostingEdition.zip
unzip -o "/tmp/JTS3ServerMod_HostingEdition.zip"
mv /tmp/JTS3ServerMod_HostingEdition /usr/local/share/teamspeak-bot
cp -R /usr/local/share/teamspeak-bot/webinterface/* /usr/local/www/apache24/data
rm /usr/local/www/apache24/data/index.html
#chmod /usr/local/www/apache24/data
#chown /usr/local/www/apache24/data

# create database
echo "create database ts3" | mysql -u root

}

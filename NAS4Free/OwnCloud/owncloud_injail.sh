#!/bin/sh
##### START OF CONFIGURATION SECTION #####


#   In order to use this script, the following variables must be defined by the user:
#
#   server_port:  This value is used to specify which port Owncloud 
#	              will be listening to. This is necessary because some installations of 
#	              N4F have had trouble with the administrative webgui showing up, even 
#	              when browsing to the jail's IP.
#     
#	server_ip:    This value is used to specify which ip address Owncloud 
#	              will be listening to. This is necessary because it keeps the jail from
#                 listening on all ip's
#
#   owncloud_version:   This is the version of owncloud you would like to download.

###! IMPORTANT ! DO NOT IGNORE ! ###
server_port="81"
server_ip="192.168.1.200"
owncloud_version="8.2.2"
### No need to edit below here ###



##### END OF CONFIGURATION SECTION #####

#
#	This is a simple script to automate the installation of Owncloud within a 
#	jailed environment.
#   Copyrighted 2013 by Matthew Kempe under the Beerware License.
#   Updated by Nostalgist92 as it hadn't been updated in a while I took it upon myself to do so it would work with the most recent N4F version.

# define our bail out shortcut function anytime there is an error - display 
# the error message, then exit returning 1.
exerr () { echo -e "$*" >&2 ; exit 1; }


## Begin sanity checks
# None, as this script is intended to be run from the command line

echo -e "\033[1;30m##################################################\033[0m" 
echo "#   Welcome to the owncloud installer!"
echo -e "\033[1;30m################################################## \033[0m" 

echo " " 
echo -e "\033[1;30m##################################################\033[0m" 
echo "#   Let's start by installing some stuff!!"
echo -e "\033[1;30m################################################## \033[0m"
echo " "
## End sanity checks
# Install packages
pkg install -y lighttpd php56-openssl php56-ctype php56-curl php56-dom php56-fileinfo php56-filter php56-gd php56-hash php56-iconv php56-json php56-mbstring php56-mysql php56-pdo php56-pdo_mysql php56-pdo_sqlite php56-session php56-simplexml php56-sqlite3 php56-xml php56-xmlrpc php56-xmlwriter php56-gettext php56-mcrypt php56-zip php56-zlib php56-posix mp3info mysql56-server pecl-apcu

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
echo "Done hardening mySQL - performing key operations"
echo -e "\033[1;30m################################################## \033[0m"
echo " "
cd ~
openssl genrsa -des3 -out server.key 1024
echo " " 
echo -e "\033[1;30m##################################################\033[0m" 
echo "Removing password from key"
echo -e "\033[1;30m################################################## \033[0m"
echo " "
openssl rsa -in server.key -out no.pwd.server.key
echo " " 
echo -e "\033[1;30m##################################################\033[0m" 
echo "Creating cert request. The Common Name should match the URL you want to use"
echo -e "\033[1;30m################################################## \033[0m"
echo " "
openssl req -new -key no.pwd.server.key -out server.csr

echo " " 
echo -e "\033[1;30m##################################################\033[0m" 
echo "Creating cert & pem file & moving to proper location"
echo -e "\033[1;30m################################################## \033[0m"
echo " "
openssl x509 -req -days 365 -in /root/server.csr -signkey /root/no.pwd.server.key -out /root/server.crt
cat no.pwd.server.key server.crt > server.pem
mkdir /usr/local/etc/lighttpd/ssl
cp server.crt /usr/local/etc/lighttpd/ssl
chown -R www:www /usr/local/etc/lighttpd/ssl/
chmod 0600 server.pem

echo " " 
echo -e "\033[1;30m##################################################\033[0m" 
echo "Creating backup of lighttpd config"
echo -e "\033[1;30m################################################## \033[0m"
echo " " 
cp /usr/local/etc/lighttpd/lighttpd.conf /usr/local/etc/lighttpd/old_config.bak

echo " " 
echo -e "\033[1;30m##################################################\033[0m" 
echo "Modifying lighttpd.conf file"
echo -e "\033[1;30m################################################## \033[0m"
echo " "
cat "/usr/local/etc/lighttpd/old_config.bak" | \
	sed -r '/^var.server_root/s|"(.*)"|"/usr/local/www/owncloud"|' | \
	sed -r '/^server.use-ipv6/s|"(.*)"|"disable"|' | \
	sed -r '/^server.document-root/s|"(.*)"|"/usr/local/www/owncloud"|' | \
	sed -r '/^#server.bind/s|(.*)|server.bind = "'"${server_ip}"'"|' | \
	sed -r '/^\$SERVER\["socket"\]/s|"0.0.0.0:80"|"'"${server_ip}"':'"${server_port}"'"|' | \
	sed -r '/^server.port/s|(.*)|server.port = '"${server_port}"'|' > \
	"/usr/local/etc/lighttpd/lighttpd.conf"

echo " " 
echo -e "\033[1;30m##################################################\033[0m" 
echo "Adding stuff to lighttpd.conf file"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

echo 'ssl.engine = "enable"' >> /usr/local/etc/lighttpd/lighttpd.conf
echo 'ssl.pemfile = "/root/server.pem"' >> /usr/local/etc/lighttpd/lighttpd.conf
echo 'ssl.ca-file = "/usr/local/etc/lighttpd/ssl/server.crt"' >> /usr/local/etc/lighttpd/lighttpd.conf
echo 'ssl.cipher-list  = "ECDHE-RSA-AES256-SHA384:AES256-SHA256:RC4-SHA:RC4:HIGH:!MD5:!aNULL:!EDH:!AESGCM"' >> /usr/local/etc/lighttpd/lighttpd.conf
echo 'ssl.honor-cipher-order = "enable"' >> /usr/local/etc/lighttpd/lighttpd.conf
echo 'ssl.disable-client-renegotiation = "enable"' >> /usr/local/etc/lighttpd/lighttpd.conf
echo '$HTTP["url"] =~ "^/data/" {' >> /usr/local/etc/lighttpd/lighttpd.conf
echo 'url.access-deny = ("")' >> /usr/local/etc/lighttpd/lighttpd.conf
echo '}' >> /usr/local/etc/lighttpd/lighttpd.conf
echo '$HTTP["url"] =~ "^($|/)" {' >> /usr/local/etc/lighttpd/lighttpd.conf
echo 'dir-listing.activate = "disable"' >> /usr/local/etc/lighttpd/lighttpd.conf
echo '}' >> /usr/local/etc/lighttpd/lighttpd.conf
echo 'cgi.assign = ( ".php" => "/usr/local/bin/php-cgi" )' >> /usr/local/etc/lighttpd/lighttpd.conf
echo 'server.modules += ( "mod_setenv" )' >> /usr/local/etc/lighttpd/lighttpd.conf
echo '$HTTP["scheme"] == "https" {' >> /usr/local/etc/lighttpd/lighttpd.conf
echo '    setenv.add-response-header  = ( "Strict-Transport-Security" => "max-age=15768000")' >> /usr/local/etc/lighttpd/lighttpd.conf
echo '}' >> /usr/local/etc/lighttpd/lighttpd.conf

echo " " 
echo -e "\033[1;30m##################################################\033[0m" 
echo "Enabling the fastcgi module"
echo -e "\033[1;30m################################################## \033[0m"
echo " "
cp /usr/local/etc/lighttpd/modules.conf /usr/local/etc/lighttpd/old_modules.bak
cat "/usr/local/etc/lighttpd/old_modules.bak" | \
	sed -r '/^#include "conf.d\/fastcgi.conf"/s|#||' > \
	"/usr/local/etc/lighttpd/modules.conf"

echo " " 
echo -e "\033[1;30m##################################################\033[0m" 
echo "Adding stuff to fastcgi.conf file"
echo -e "\033[1;30m################################################## \033[0m"
echo " "
echo 'fastcgi.server = ( ".php" =>' >> /usr/local/etc/lighttpd/conf.d/fastcgi.conf
echo '((' >> /usr/local/etc/lighttpd/conf.d/fastcgi.conf
echo '"socket" => "/tmp/php.socket",' >> /usr/local/etc/lighttpd/conf.d/fastcgi.conf
echo '"bin-path" => "/usr/local/bin/php-cgi",' >> /usr/local/etc/lighttpd/conf.d/fastcgi.conf
echo '"allow-x-send-file" => "enable",' >> /usr/local/etc/lighttpd/conf.d/fastcgi.conf
echo '"bin-environment" => (' >> /usr/local/etc/lighttpd/conf.d/fastcgi.conf
echo '"MOD_X_SENDFILE2_ENABLED" => "1",' >> /usr/local/etc/lighttpd/conf.d/fastcgi.conf
echo '"PHP_FCGI_CHILDREN" => "16",' >> /usr/local/etc/lighttpd/conf.d/fastcgi.conf
echo '"PHP_FCGI_MAX_REQUESTS" => "10000"' >> /usr/local/etc/lighttpd/conf.d/fastcgi.conf
echo '),' >> /usr/local/etc/lighttpd/conf.d/fastcgi.conf
echo '"min-procs" => 1,' >> /usr/local/etc/lighttpd/conf.d/fastcgi.conf
echo '"max-procs" => 1,' >> /usr/local/etc/lighttpd/conf.d/fastcgi.conf
echo '"idle-timeout" => 20' >> /usr/local/etc/lighttpd/conf.d/fastcgi.conf
echo '))' >> /usr/local/etc/lighttpd/conf.d/fastcgi.conf
echo ' )' >> /usr/local/etc/lighttpd/conf.d/fastcgi.conf

echo " " 
echo -e "\033[1;30m##################################################\033[0m" 
echo "Obtaining corrected MIME .conf file for lighttpd to use"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

mv /usr/local/etc/lighttpd/conf.d/mime.conf /usr/local/etc/lighttpd/conf.d/mime_conf.bak
fetch -o /usr/local/etc/lighttpd/conf.d/mime.conf http://www.xenopsyche.com/mkempe/oc/mime.conf

echo " " 
echo -e "\033[1;30m##################################################\033[0m" 
echo "Packages installed - creating www folder"
echo -e "\033[1;30m################################################## \033[0m"
echo " "
mkdir /usr/local/www

echo " "
# Get owncloud, extract it, copy it to the webserver, and have the jail 
# assign proper permissions
echo -e "\033[1;30m##################################################\033[0m" 
echo "www folder created - now downloading owncloud"
echo -e "\033[1;30m################################################## \033[0m"
echo " "
cd "/tmp"
fetch "https://download.owncloud.org/community/owncloud-${owncloud_version}.tar.bz2"
tar xf "owncloud-${owncloud_version}.tar.bz2" -C /usr/local/www
chown -R www:www /usr/local/www/

echo " " 
echo -e "\033[1;30m##################################################\033[0m" 
echo "Adding lighttpd to rc.conf"
echo -e "\033[1;30m################################################## \033[0m"
echo " "
echo 'lighttpd_enable="YES"' >> /etc/rc.conf

echo " " 
echo -e "\033[1;30m##################################################\033[0m" 
echo "  Done, lighttpd should start up automatically!"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

echo " "
echo -e "\033[1;30m##################################################\033[0m" 
echo "Attempting to start webserver."
echo "If it fails and says Cannot 'start' lighttpd, manually add"
echo "    lighttpd_enable="YES" to /etc/rc.conf"
echo "Command being run here is:"
echo -e "    \033[1;35m/usr/local/etc/rc.d/lighttpd start\033[0m"
echo -e "\033[1;30m################################################## \033[0m"
echo " "
/usr/local/etc/rc.d/lighttpd start

echo " " 
echo -e "\033[1;30m##################################################\033[0m" 
echo "It looks like we finished here!!! NICE"
echo -e "Now head to \033[1;32mhttps://$server_ip:$server_port\033[0m (as defined at the start of the script)"
echo " via your browser and complete your OwnCloud setup! "
echo " "
echo -e "To get \033[1;37mMemory Caching\033[0m to work you'll have to enable this manually."
echo -e "Head to this file \033[1;36m/usr/local/www/owncloud/config/config.php\033[0m and add:"
echo -e "\033[1;33m  'memcache.local' => '\OC\Memcache\APCu',\033[0m right above the last line."
echo -e "Once you've edited this file, restart the server with:" 
echo -e "\033[1;35m  /usr/local/etc/rc.d/lighttpd restart\033[0m"
echo " "
echo -e "\033[1;37mThanks to fsbruva for creating the original script \033[0m" 
echo -e "\033[1;37mModifications made by Nostalgist92 \033[0m" 
echo -e "\033[1;30m################################################## \033[0m"
echo " "
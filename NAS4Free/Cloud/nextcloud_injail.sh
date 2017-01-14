#!/bin/sh
# NextCloud Script               Version: 1.03 (January 14, 2017)
# By Ashley Townsend (Nozza)    Copyright: Beerware License
################################################################################
# While using "nano" to edit this script (nano /aioscript.sh),
# Use the up, down, left and right arrow keys to navigate. Once done editing,
# Press "X" while holding "Ctrl", Press "Y" then press "Enter" to save changes
################################################################################
##### START OF CONFIGURATION SECTION #####
#
#   In order to use this script, the following variables must be defined by the user:
#
#   server_port:  This value is used to specify which port NextCloud will be
#                 listening to. This is necessary because some installations of
#                 N4F have had trouble with the administrative webgui showing up,
#                 even when browsing to the jail's IP.
#
#   server_ip:    This value is used to specify which ip address NextCloud will be
#                 listening to. This is necessary because it keeps the jail from
#                 listening on all ip's
#
#   nextcloud_version:   This is the version of NextCloud you would like to download.
#                       You can replace this with "latest" but it isn't recommended
#                       as updates to nextcloud may require an updated script
#                       This script has only been tested on most 8.x.x versions
#                       up to version 9.0.0
#
#
###! IMPORTANT ! DO NOT IGNORE ! ###
server_port="81"
server_ip="192.168.1.200"
nextcloud_version="11.0.0"
database_name="nextcloud"
# Press "X" while holding "Ctrl", Press "Y" then press "Enter" to save changes
### No need to edit below here ###
##### END OF CONFIGURATION SECTION #####
################################################################################



###
#	This is a simple script to automate the installation of NextCloud within a
#	jailed environment.
#   Maintainer: Nostalgist92 as Matthew Kempe's old script hadn't been updated
#   for NAS4Free 10.x (This should work fine for 9.x versions if you have the
#   new package management tool installed)
###



confirm ()
{
# Confirm with the user
read -r -p "   Continue? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              echo -e "${url} Great! Moving on..${nc}"
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo -e "${alt}Stopping script..${nc}"
              echo " "
              exit
              ;;
esac
}

cloud.trusteddomain.fix ()
{
# Confirm with the user
echo " "
echo -e "${emp} Please finish the nextcloud setup before continuing${nc}"
echo -e "${msg} Head to ${url}https://$server_ip:$server_port ${msg}to do this.${nc}"
echo -e "${msg} Fill out the page you are presented with and hit finish${nc}"
echo " "
echo -e "${msg} Admin username & password = whatever you choose${nc}"
echo " "
echo -e "${emp} Make sure you click 'Storage & database'${nc}"
echo " "
echo -e "${msg} Database user = ${qry}root${nc} | ${msg} Database password = ${nc}"
echo -e "${msg} the ${qry}mysql password${msg} you chose earlier during the script.${nc}"
echo -e "${msg} Database name =${qry} ${database_name} ${nc}"
echo " "
echo " Once the page reloads,"
read -r -p "   do you have a 'untrusted domain' error? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, let's fix that.
              echo " "
              echo -e "${url} Doing some last second changes to fix that..${nc}"
              echo " "
              # Prevent "Trusted Domain" error
              echo "    '${server_ip}'," >> /usr/local/www/nextcloud/config/trusted.txt
              cp /usr/local/www/nextcloud/config/config.php /usr/local/www/nextcloud/config/old_config.bak
              cat "/usr/local/www/nextcloud/config/old_config.bak" | \
                sed '8r /usr/local/www/nextcloud/config/trusted.txt' > \
                "/usr/local/www/nextcloud/config/config.php"
              rm /usr/local/www/nextcloud/config/trusted.txt
              echo -e " Done, continuing with the rest of the script"
               ;;
    *)
              # If no, just continue like normal.
              echo " "
              echo -e "${qry} Great!, no need to do anything, continuing with script..${nc}"
              echo " "
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



## Begin sanity checks
# None, as this script is intended to be run from the command line
## End sanity checks



echo " "
echo -e "${sep}"
echo -e "${msg}   Welcome to the NextCloud installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's start with double checking some things${nc}"
echo -e "${sep}"
echo " "

echo -e "${msg} Is this script running ${alt}INSIDE${msg} of a jail?${nc}"
confirm
echo " "
echo -e "${msg} Checking to see if you need to modify the script${nc}"
echo -e "${msg} If ${emp}ANY${msg} of these ${emp}DON'T${msg} match YOUR setup, answer with ${emp}no${nc}."
echo -e " "
echo -e "      #1: ${msg}Is this your jails IP? ${qry}$server_ip${nc}"
echo -e "      #2: ${msg}Is this the port you want to use? ${qry}$server_port${nc}"
echo -e "      #3: ${msg}Is this the NextCloud version you want to install? ${qry}$nextcloud_version${nc}"
echo -e "      #4: ${msg}Is this the NextCloud database name you want to use? ${qry}$database_name${nc}"
echo -e " "
echo -e "${emp} If #1 or #2 are incorrect you will encounter issues!${nc}"
confirm
echo " "
echo -e "${url} Awesome, now we are ready to get on with it!${nc}"

echo " "
echo -e "${sep}"
echo -e "${msg}   Let's get to installing some stuff!!${nc}"
echo -e "${sep}"
echo " "

# Install packages
pkg install -y lighttpd php70-openssl php70-ctype php70-curl php70-dom php70-fileinfo php70-filter php70-gd php70-hash php70-iconv php70-json php70-mbstring php70-pdo php70-pdo_mysql php70-pdo_sqlite php70-session php70-simplexml php70-sqlite3 php70-xml php70-xmlrpc php70-xmlwriter php70-xmlreader php70-gettext php70-mcrypt php70-zip php70-zlib php70-posix php70-APCu mp3info mysql56-server pecl-apcu

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
echo -e "${msg} Creating database for nextcloud${nc}"
echo -e "${sep}"
echo " "

mysql -u root -e "create database ${database_name}";
echo -e "${msg} Database was created: ${database_name}.${nc}"

echo " "
echo -e "${sep}"
echo -e "${msg} Securing the install. Default root password is blank,${nc}"
echo -e "${msg} you want to provide a strong root password, remove the${nc}"
echo -e "${msg} anonymous accounts, disallow remote root access,${nc}"
echo -e "${msg} remove the test database, and reload privilege tables${nc}"
echo -e "${sep}"
echo " "

mysql_secure_installation

echo " "
echo -e "${sep}"
echo -e "${msg} Done with MySQL - Performing key operations now${nc}"
echo -e "${sep}"
echo " "

cd ~
openssl genrsa -des3 -out server.key 1024

echo " "
echo -e "${sep}"
echo -e "${msg} Removing password from key${nc}"
echo -e "${sep}"
echo " "

openssl rsa -in server.key -out no.pwd.server.key

echo " "
echo -e "${sep}"
echo -e "${msg} Creating cert request. The Common Name should match${nc}"
echo -e "${msg} the URL you want to use${nc}"
echo -e "${sep}"
echo " "

openssl req -new -key no.pwd.server.key -out server.csr

echo " "
echo -e "${sep}"
echo -e "${msg} Creating cert & pem file & moving to proper location${nc}"
echo -e "${sep}"
echo " "

openssl x509 -req -days 365 -in /root/server.csr -signkey /root/no.pwd.server.key -out /root/server.crt
cat no.pwd.server.key server.crt > server.pem
mkdir /usr/local/etc/lighttpd/ssl
cp server.crt /usr/local/etc/lighttpd/ssl
chown -R www:www /usr/local/etc/lighttpd/ssl/
chmod 0600 server.pem

echo " "
echo -e "${sep}"
echo -e "${msg} Creating backup of lighttpd config${nc}"
echo -e "${sep}"
echo " "

cp /usr/local/etc/lighttpd/lighttpd.conf /usr/local/etc/lighttpd/old_config.bak

echo " "
echo -e "${sep}"
echo -e "${msg} Modifying lighttpd.conf file${nc}"
echo -e "${sep}"
echo " "

cat "/usr/local/etc/lighttpd/old_config.bak" | \
	sed -r '/^var.server_root/s|"(.*)"|"/usr/local/www/nextcloud"|' | \
	sed -r '/^server.use-ipv6/s|"(.*)"|"disable"|' | \
	sed -r '/^server.document-root/s|"(.*)"|"/usr/local/www/nextcloud"|' | \
	sed -r '/^#server.bind/s|(.*)|server.bind = "'"${server_ip}"'"|' | \
	sed -r '/^\$SERVER\["socket"\]/s|"0.0.0.0:80"|"'"${server_ip}"':'"${server_port}"'"|' | \
	sed -r '/^server.port/s|(.*)|server.port = '"${server_port}"'|' > \
	"/usr/local/etc/lighttpd/lighttpd.conf"

echo " "
echo -e "${sep}"
echo -e "${msg} Adding stuff to lighttpd.conf file${nc}"
echo -e "${sep}"
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
echo -e "${sep}"
echo -e "${msg} Enabling the fastcgi module${nc}"
echo -e "${sep}"
echo " "

cp /usr/local/etc/lighttpd/modules.conf /usr/local/etc/lighttpd/old_modules.bak
cat "/usr/local/etc/lighttpd/old_modules.bak" | \
	sed -r '/^#include "conf.d\/fastcgi.conf"/s|#||' > \
	"/usr/local/etc/lighttpd/modules.conf"

echo " "
echo -e "${sep}"
echo -e "${msg} Adding stuff to fastcgi.conf file${nc}"
echo -e "${sep}"
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
echo -e "${sep}"
echo -e "${msg} Obtaining corrected MIME.conf file for lighttpd to use${nc}"
echo -e "${sep}"
echo " "

mv /usr/local/etc/lighttpd/conf.d/mime.conf /usr/local/etc/lighttpd/conf.d/mime_conf.bak
fetch -o /usr/local/etc/lighttpd/conf.d/mime.conf http://www.xenopsyche.com/mkempe/oc/mime.conf

echo " "
echo -e "${sep}"
echo -e "${msg} Modifying php.ini${nc}"
echo -e "${sep}"
echo " "

echo always_populate_raw_post_data = -1 > /usr/local/etc/php.ini

echo " "
echo -e "${sep}"
echo -e "${msg} Creating www folder and downloading NextCloud${nc}"
echo -e "${sep}"
echo " "

mkdir -p /usr/local/www
# Get NextCloud, extract it, copy it to the webserver
# and have the jail assign proper permissions
cd "/tmp"
fetch "https://download.nextcloud.com/server/releases/nextcloud-${nextcloud_version}.tar.bz2"
tar xf "nextcloud-${nextcloud_version}.tar.bz2" -C /usr/local/www
chown -R www:www /usr/local/www/

echo " "
echo -e "${sep}"
echo -e "${msg} Adding lighttpd to rc.conf${nc}"
echo -e "${sep}"
echo " "

echo 'lighttpd_enable="YES"' >> /etc/rc.conf

echo " "
echo -e "${sep}"
echo -e "${msg}  Done, lighttpd should start up automatically!${nc}"
echo -e "${sep}"
echo " "

echo " "
echo -e "${sep}"
echo -e "${msg} Attempting to start webserver.${nc}"
echo -e "${msg} If you get a Cannot 'start' lighttpd error, add:${nc}"
echo -e "\033[1;33m     lighttpd_enable="YES"${nc}   to   \033[1;36m/etc/rc.conf${nc}"
echo -e "${msg} Command being run here is:"
echo -e "${cmd}     /usr/local/etc/rc.d/lighttpd start${nc}"
echo -e "${sep}"
echo " "

/usr/local/etc/rc.d/lighttpd start

#echo " "
#echo -e "${sep}"
#echo -e "${msg} Enable Memory Caching${nc}"
#echo -e "${sep}"
#echo " "

#TODO: Enable Memory Caching by default
#echo "  'memcache.local' => '\OC\Memcache\APCu'," >> #/usr/local/www/nextcloud/config/memcache.txt
#cp /usr/local/www/nextcloud/config/config.php /usr/local/www/nextcloud/config/old_config.bak
#cat "/usr/local/www/nextcloud/config/old_config.bak" | \
#	sed '21r /usr/local/www/nextcloud/config/memcache.txt' > \
#    "/usr/local/www/nextcloud/config/config.php"
#rm /usr/local/www/nextcloud/config/memcache.txt

echo " "
echo -e "${sep}"
echo -e "${msg} Now to finish nextcloud setup${nc}"
echo -e "${sep}"
echo " "

cloud.trusteddomain.fix

echo " "
echo -e "${sep}"
echo -e "${msg} It looks like we finished here!!! NICE${nc}"
echo -e "${msg} Now you can head to ${url}https://$server_ip:$server_port${nc}"
echo -e "${msg} to use your nextcloud whenever you wish!${nc}"
echo " "
echo " "
echo " "
echo -e "${emp} Memory Caching ${msg}will have to be enabled manually.${nc}"
echo -e "${msg} This is entirely optional. Head to this file:${nc}"
echo -e "\033[1;36m    /usr/local/www/nextcloud/config/config.php${nc} ${msg}and add:${nc}"
echo -e "\033[1;33m    'memcache.local' => '\OC\Memcache\APCu',${nc}"
echo -e "${msg} right above the last line.${nc}"
echo -e "${msg} Once you've edited this file, restart the server with:${nc}"
echo -e "${cmd}   /usr/local/etc/rc.d/lighttpd restart${nc}"
echo " "
echo " "
echo " "
echo -e "${msg} If you need any help, visit the forums here:${nc}"
echo -e "${url} http://forums.nas4free.org/viewtopic.php?f=79&t=9383${nc}"
echo -e "${msg} Or jump on my Discord server${nc}"
echo -e "${url} https://discord.gg/0bXnhqvo189oM8Cr${nc}"
echo -e "${sep}"
echo " "

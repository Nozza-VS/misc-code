#!/bin/sh
# NextCloud Script v2           Version: 2.0.4 (May 17, 2017)
# By Ashley Townsend (Nozza)    Copyright: Beerware License
#===============================================================================
### NEXTCLOUD CONFIRM INSTALL

confirm.install.nextcloud ()
{
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

echo -e "${sep}"
echo -e "${msg}   Let's start with double checking some things${nc}"
echo -e "${sep}"
echo " "

echo -e "${msg} Is this script running ${alt}INSIDE${msg} of a jail?${nc}"

confirm

#echo " "
#echo -e "${msg} Checking to see if you need to modify the script${nc}"
#echo -e "${msg} If ${emp}ANY${msg} of these ${emp}DON'T${msg} match YOUR setup, answer with ${emp}no${nc}."
#echo -e " "
#echo -e "      ${alt}#1: ${msg}Is this your jails IP? ${qry}$server_ip${nc}"
#echo -e "      ${alt}#2: ${msg}Is this the port you want to use? ${qry}$server_port${nc}"
#echo -e "      ${alt}#3: ${msg}Is this the NextCloud version you want to install? ${qry}$nextcloud_version${nc}"
#echo -e " "
#echo -e "${emp} If #1 or #2 are incorrect you will encounter issues!${nc}"

#confirm

echo " "

# Confirm with the user
echo -e "${inf} Final confirmation before installing nextcloud.${nc}"
read -r -p "   Confirm Installation of NextCloud? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.nextcloud
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}



#===============================================================================
### NEXTCLOUD INSTALL

install.nextcloud ()
{

nextcloud.continue ()
{
echo -e "${msep}"
echo -e "${emp}   Press Enter To Continue${nc}"
echo -e "${msep}"
read -r -p " " response
case "$response" in
    *)
              ;;
esac
}

nextcloud.options ()
{
echo " "
echo -e "${msg} What is your jails IP?${nc}"
echo -e "${alt} This MUST be your jails IP${nc}"
printf "${inf} Detected IP: ${nc}" ; ifconfig | grep -e "inet" -e "addr:" | grep -v "inet6" | grep -v "127.0.0.1" | head -n 1 | awk '{print $2}'
echo " "
printf "${emp} Set IP: ${nc}" ; read userselected_ip
echo -e "${fin}    IP set to: ${msg}${userselected_ip}${nc}"
echo " "
echo -e "${msg} What port do you want to run it on?${nc}"
echo -e "${inf}    Recommended: ${msg}81${nc}"
echo " "
printf "${emp} Set Port: ${nc}" ; read userselected_port
echo -e "${fin}    Port set to: ${msg}${userselected_port}${nc}"
echo " "
echo -e "${msg} What version would you like to install${nc}"
echo -e "${inf}    Tested & Confirmed Working: 11.0.0"
echo " "
printf "${emp} Set Version: ${nc}" ; read -r userselected_version
echo -e "${fin}    Version set to: ${msg}${userselected_version}${nc}"
echo " "
nextcloud.continue
#echo " "
#echo -e "${emp} Only do so if you know what you're doing!${nc}"
#echo " Default Database name: nextcloud"
#read -r -p " Set Database name to something else? [y/N] " response
#    case $response in
#        [yY][eE][sS]|[yY])
#			echo " "
#			echo -e "${msg} What port do you want to run it on?${nc}"
#			echo "Recommended: 81"
#			echo " "
#			echo " Input Port:"
#			read userselected_dbname
#			;;
#		*)
#			database_name="nextcloud"
#			;;
#	esac
}

echo " "
echo -e "${sep}"
echo -e "${msg}   Welcome to the NextCloud installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   First, some configuration${nc}"
echo -e "${sep}"
echo " "

nextcloud.options

echo " "
echo -e "${sep}"
echo -e "${msg}   Let's get to installing some stuff!!${nc}"
echo -e "${sep}"
echo " "

# Install packages
pkg install -y lighttpd php70-openssl php70-ctype php70-curl php70-dom php70-fileinfo php70-filter php70-gd php70-hash php70-iconv php70-json php70-mbstring php70-pdo php70-pdo_mysql php70-pdo_sqlite php70-session php70-simplexml php70-sqlite3 php70-xml php70-xmlrpc php70-xmlwriter php70-xmlreader php70-gettext php70-mcrypt php70-zip php70-zlib php70-posix mp3info mysql56-server
# php70-APCu - No longer in repositories
# Alternative
# php70-memcache php70-memcached

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
echo -e "${msg} Done hardening MySQL - Performing key operations now${nc}"
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
	sed -r '/^#server.bind/s|(.*)|server.bind = "'"${userselected_ip}"'"|' | \
	sed -r '/^\$SERVER\["socket"\]/s|"0.0.0.0:80"|"'"${userselected_ip}"':'"${userselected_port}"'"|' | \
	sed -r '/^server.port/s|(.*)|server.port = '"${userselected_port}"'|' > \
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
fetch "https://download.nextcloud.com/server/releases/nextcloud-${userselected_version}.tar.bz2"
tar xf "nextcloud-${userselected_version}.tar.bz2" -C /usr/local/www
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



echo " "
echo -e "${sep}"
echo -e "${msg} It looks like we finished here!!! NICE${nc}"
echo -e "${msg} Now you can head to ${url}https://$userselected_ip:$userselected_port${nc}"
echo -e "${msg} to use your nextcloud whenever you wish!${nc}"
echo " "
echo " "
echo " "
echo -e "${emp} Memory Caching ${msg}is an optional feature that is not enabled by default${nc}"
echo -e "${msg} This is entirely optional and any messages about it can be safely ignored.${nc}"
echo -e "${msg} If you wish to enable it, you can do so via the 'Other Options' menu.${nc}"
echo " "
echo " "
echo " "
echo -e "${msg} If you need any help, visit the forums here:${nc}"
echo -e "${url} http://forums.nas4free.org/viewtopic.php?f=79&t=9383${nc}"
echo -e "${msg} Or jump on my Discord server${nc}"
echo -e "${url} https://discord.gg/0bXnhqvo189oM8Cr${nc}"
echo -e "${sep}"
echo " "

nextcloud.continue

echo " "

}



#===============================================================================

confirm.install.nextcloud
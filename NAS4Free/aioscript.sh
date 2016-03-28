#!/bin/sh
# AIO Script - Version: 1.0.3 (March 28, 2016)
################################################################################
##### START OF CONFIGURATION SECTION #####
#
#   In some instances of this script, the following variables must be defined
#   by the user:
#
#   cloud_server_port:  Used to specify the port Owncloud will be listening to.
#                       Needed due to some installs of N4F having trouble with
#            the admin webgui showing up, even when browsing to the jail's IP.
#
#
#   cloud_server_ip:    This value is used to specify the ip address Owncloud
#                       will listen to. This is needed to keep the jail from
#            listening on all ip's
#
#   owncloud_version:   The version of ownCloud you wish to install. You can set
#            this with "latest" but it isn't recommended as owncloud updates may
#            require an updated script. Has been tested on v8.x.x up to v9.0.0.
#
###! OWNCLOUD CONFIG ! IMPORTANT ! DO NOT IGNORE ! ###
cloud_server_port="81"
cloud_server_ip="192.168.1.200"
owncloud_version="9.0.0"

### OTHER APP CONFIG ###
jail_ip="192.168.1.200" # Note: No need to change this for OwnCloud installs
                        # Only change this for OTHER jails/apps
                        # MUST be different to cloud_server_ip if you have
                        # installed OwnCloud previously.
#
### No need to edit below here ###
##### END OF CONFIGURATION SECTION #####
################################################################################



#Grab the date & time to be used later
backupdate=$(date +"%Y.%m.%d-%I.%M%p")

# Add some colour!
nc='\033[0m'        # No Color
alt='\033[0;31m'    # Alert Text
emp='\033[1;31m'    # Emphasis Text
msg='\033[1;37m'    # Message Text
url='\033[1;32m'    # URL
qry='\033[0;36m'    # Query Text
sep='\033[1;30m-------------------------------------------------------\033[0m'    # Line Seperator
ssep='\033[1;30m#----------------------#\033[0m'    # Small Line Seperator
cmd='\033[1;35m'    # Command to be entered
fin='\033[0;32m'    # Green Text
inf='\033[0;33m'    # Information Text



################################################################################
##### CONTACT
################################################################################

gethelp ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} Ways of contacting me / getting help from others:${nc}"
        echo -e "${sep}"
        echo " "
        echo -e "${fin}   My Discord Support (Usually faster responses):${nc}"
        echo -e "${msg}      https://discord.gg/0bXnhqvo189oM8Cr${nc}"
        echo -e "${fin}   My Email (Might add this later, Discord is easier though):${nc}"
        echo -e "${msg}      myemail@domain.com${nc}"
        echo -e "${fin}   Forums:${nc}"
        echo -e "${msg}      NAS4Free Forums - OwnCloud:${nc}"
        echo -e "${url}      http://forums.nas4free.org/viewtopic.php?f=79&t=9383${nc}"
        echo -e "${msg}      VS Forums:${nc}"
        echo -e "${url}      forums.vengefulsyndicate.com${nc}"
        echo " "
        echo -e "${emp}   Press Enter To Go Back To The Menu${nc}"

        read choice

        case $choice in
            *)
                 return
                 ;;
        esac
done
}



################################################################################
##### OTHER OPTIONS
################################################################################

#------------------------------------------------------------------------------#
### OWNCLOUD - ENABLE MEMORY CACHING
#------------------------------------------------------------------------------#

cloud.enablememcache ()
{
echo -e "${msg} This part of the script is unfinished currently :("
echo " "
#echo -e "${msg} This is entirely optional. Head to this file:${nc}"
#echo -e "\033[1;36m    /usr/local/www/owncloud/config/config.php${nc} ${msg}and add:${nc}"
#echo -e "\033[1;33m    'memcache.local' => '\OC\Memcache\APCu',${nc}"
#echo -e "${msg} right above the last line.${nc}"
#echo -e "${msg} Once you've edited this file, restart the server with:${nc}"
#/usr/local/etc/rc.d/lighttpd restart
}

################################################################################
##### INFORMATION / HOW-TO'S / OTHER INSCTRUCTIONS
################################################################################

#------------------------------------------------------------------------------#
### OWNCLOUD - HOW-TO FINISH SETUP
#------------------------------------------------------------------------------#

cloud.howtofinishsetup ()
{
while [ "$choice" ]
do
echo " "
echo -e "${emp} Follow these instructions carefully"
echo " "
echo -e "${msg} In a web browser, head to: ${url}https://$cloud_server_ip:$cloud_server_port${nc}"
echo " "
echo -e "${msg} Admin Username: ${inf}Enter your choice of username${nc}"
echo -e "${msg} Admin Password: ${inf}Enter your choice of password${nc}"
echo " "
echo -e "${alt}    Click Database options and choose MySQL${nc}"
echo -e "${msg} Database username: ${inf}root${nc}"
echo -e "${msg} Database password: ${inf}THE PASSWORD YOU ENTERED EARLIER FOR MYSQL${nc}"
echo -e "${msg} Database host: ${inf}Leave as is (Should be localhost)${nc}"
echo -e "${msg} Database name: ${inf}Your choice (owncloud is fine)${nc}"
echo " "
echo -e "${emp} Click Finish Setup, the page will take a moment to refresh${nc}"
echo -e "${msg} After it refreshes, if you are seeing a 'Trusted Domain' error,${nc}"
echo -e "${msg} head back to the owncloud menu and select option 4.${nc}"
echo " "
echo -e "${emp}   Press Enter To Go Back To The Menu${nc}"

        read choice

        case $choice in
            *)
                 return
                 ;;
        esac
done
}



#------------------------------------------------------------------------------#
### THEBRIG - CREATING A JAIL
#------------------------------------------------------------------------------#

thebrig.createajail ()
{
echo -e "${emp} This part of the script is unfinished currently :("
echo " "
}



#------------------------------------------------------------------------------#
### THEBRIG - ENABLING PORT TREES
#------------------------------------------------------------------------------#

thebrig.enableportree ()
{
echo -e "${emp} This part of the script is unfinished currently :("
echo " "
}



#------------------------------------------------------------------------------#
### EMBY SERVER - UPDATE FFMPEG (FOR TRANSCODING)
#------------------------------------------------------------------------------#

thebrig.updateffmpeg ()
{
echo -e "${emp} This part of the script is unfinished currently :("
echo " "
}



################################################################################
##### FIXES
################################################################################

#------------------------------------------------------------------------------#
### TRUSTED DOMAIN WARNING FIX
#------------------------------------------------------------------------------#

cloud.trusteddomain.fix ()
{
# Confirm with the user
echo " "
echo -e "${emp} Please finish the owncloud setup before continuing${nc}"
echo -e "${emp} Can ignore the next few steps if you've already done it.${nc}"
echo -e "${msg} Head to ${url}https://$cloud_server_ip:$cloud_server_port ${msg}to do this.${nc}"
echo -e "${msg} Fill out the page you are presented with and hit finish${nc}"
echo " "
echo -e "${msg} Admin username & password = whatever you choose${nc}"
echo " "
echo -e "${emp} Make sure you click 'Storage & database'${nc}"
echo " "
echo -e "${msg} Database user = ${qry}root${nc} | Database password = ${nc}"
echo -e "${msg} the ${qry}mysql password${msg} you chose earlier during the script.${nc}"
echo -e "${msg} Database name = your choice (just ${qry}owncloud${msg} is fine)${nc}"
echo " "
echo " When trying to access owncloud"
read -r -p "   do you have a 'untrusted domain' error? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, let's fix that.
              echo " "
              echo -e "${url} Doing some last second changes to fix that..${nc}"
              echo " "
              # Prevent "Trusted Domain" error
              echo "    '${server_ip}'," >> /usr/local/www/owncloud/config/trusted.txt
              cp /usr/local/www/owncloud/config/config.php /usr/local/www/owncloud/config/old_config.bak
              cat "/usr/local/www/owncloud/config/old_config.bak" | \
                sed '8r /usr/local/www/owncloud/config/trusted.txt' > \
                "/usr/local/www/owncloud/config/config.php"
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

#------------------------------------------------------------------------------#
### Populating Raw Post Data Fix
#------------------------------------------------------------------------------#

cloud.phpini ()
{
echo " "
echo -e "${sep}"
echo -e "${msg} Modifying php.ini${nc}"
echo -e "${msg}    (/usr/local/etc/php.ini)${nc}"
echo -e "${sep}"
echo " "

echo always_populate_raw_post_data = -1 > /usr/local/etc/php.ini
}



################################################################################
##### INSTALLERS
# TODO: Finish the rest of the installers
################################################################################

#------------------------------------------------------------------------------#
### MYSQL INSTALL

install.mysql ()
{
webmin ()
{
# Confirm with the user
read -r -p "   Install Webmin? [y/N]" response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              echo -e "${fin} Setting up Webmin..${nc}"
              pkg install -y webmin
              echo 'webmin_enable="YES"' >> /etc/rc.conf
              /usr/local/lib/webmin/setup.sh
              /usr/local/etc/rc.d/webmin restart
              echo -e "${msg} You should now be able to visit${nc}"
              echo -e "${url} http://jailip:10000 ${msg}and log in to webmin.${nc}"
              echo " "
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo -e "${inf} Skipping Webmin..${nc}"
              echo " "
              ;;
esac
}

phpmyadmin ()
{
echo " "
mkdir /usr/local/www/phpMyAdmin/config && chmod o+w /usr/local/www/phpMyAdmin/config
chmod o+r /usr/local/www/phpMyAdmin/config.inc.php
echo -e "${emp} Follow these instructions carefully before continuing:${nc}"
echo " "
echo -e "${msg} 1: In your web browser, go to ${url}http://jailip/phpMyAdmin/setup${nc}"
echo -e "${msg} 2: Click ${cmd}'New server'${msg} and select the ${cmd}'Authentication'${msg} tab.${nc}"
echo -e "${msg} 3: Under the ${cmd}'Authentication type'${msg} choose ${cmd}'http'${nc}"
echo -e "${msg}    from the drop-down list (prevents storing login${nc}"
echo -e "${msg}    credentials directly in config.inc.php)${nc}"
echo -e "${msg} 4: Also remove ${cmd}'root'${msg} from the ${cmd}'User for config auth'${nc}"
echo -e "${msg} 5: Now click ${cmd}'Apply'${msg} and you'll return to the Overview page.${nc}"
echo -e "${msg} 6: Finally, Click ${cmd}'Save'${msg} to save your configuration in${nc}"
echo -e "${msg}      /usr/local/www/phpMyAdmin/config/config.inc.php.${nc}"
echo " "
echo " Only continue once you have done the above steps"
read -r -p "   Continue? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              echo -e "${url} Great! Moving on..${nc}"
              #Now let’s move that file up one directory to /usr/local/www/phpMyAdmin where phpMyAdmin can make use of it.
              mv /usr/local/www/phpMyAdmin/config/config.inc.php /usr/local/www/phpMyAdmin
              rm -r /usr/local/www/phpMyAdmin/config
              chmod o-r /usr/local/www/phpMyAdmin/config.inc.php
              echo " "
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo -e "${alt} phpMyAdmin wont work without setting it up.${nc}"
              echo -e "${msg} It's not required though so skipping..${nc}"
              echo " "
              ;;
esac
}



echo " "
echo -e "${sep}"
echo -e "${msg}   Welcome to the MySQL guided setup script!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's start with downloading some packages.${nc}"
echo -e "${msg} If you get an error about '${qry}package management tool${nc}"
echo -e "${qry} is not yet installed${msg}', just press y then enter.${nc}"
echo -e " "
echo -e "${msg} You may also get 2 errors later from Apache:${nc}"
echo -e "${msg} AH00557 & AH00558, these can be safely ignored.${nc}"
echo -e "${sep}"
echo " "

pkg install -y nano mysql56-server mod_php56 php56-mysql php56-mysqli phpmyadmin apache24

# -------------------------------------------------------
# MySQL

echo " "
echo -e "${sep}"
echo -e "${msg}   Great, now let's get MySQL set up.${nc}"
echo -e "${sep}"
echo " "

echo 'mysql_enable="YES"' >> /etc/rc.conf
echo '[mysqld]' >> /var/db/mysql/my.cnf

/usr/local/etc/rc.d/mysql-server start

mysql_secure_installation

/usr/local/etc/rc.d/mysql-server restart

# -------------------------------------------------------
# Webmin

echo " "
echo -e "${sep}"
echo -e "${msg}   Would you like Webmin also? (Not required)${nc}"
echo -e "${sep}"
echo " "

webmin

# -------------------------------------------------------
# Apache

echo " "
echo -e "${sep}"
echo -e "${msg}   Getting there! Time for Apache setup.${nc}"
echo -e "${sep}"
echo " "

echo 'apache24_enable="YES"' >> /etc/rc.conf
service apache24 start
cp /usr/local/etc/php.ini-production /usr/local/etc/php.ini

# Configure Apache to Use PHP Module

echo '<IfModule dir_module>' >> /usr/local/etc/apache24/Includes/php.conf
echo '    DirectoryIndex index.php index.html' >> /usr/local/etc/apache24/Includes/php.conf
echo '    <FilesMatch "\.php$">' >> /usr/local/etc/apache24/Includes/php.conf
echo '        SetHandler application/x-httpd-php' >> /usr/local/etc/apache24/Includes/php.conf
echo '    </FilesMatch>' >> /usr/local/etc/apache24/Includes/php.conf
echo '    <FilesMatch "\.phps$">' >> /usr/local/etc/apache24/Includes/php.conf
echo '        SetHandler application/x-httpd-php-source' >> /usr/local/etc/apache24/Includes/php.conf
echo '    </FilesMatch>' >> /usr/local/etc/apache24/Includes/php.conf
echo '</IfModule>' >> /usr/local/etc/apache24/Includes/php.conf

# Is this next step even needed anymore?
# Note: Disabling for now, I don't think we really need this.
#echo -e "${sep}"
#echo -e "${msg}   This part needs to be done by you${nc}"
#echo -e "${sep}"
#echo " "
#echo -e "${msg} Find: ${qry}DirectoryIndex index.html${nc}"
#echo -e "${msg} and add ${qry}index.php${msg} to the end of that line${nc}"
#echo -e "${msg} It should then look like this:${nc}"
#echo -e "${qry}    DirectoryIndex index.html index.php${nc}"
#echo -e "${msg} Once you're done, press Ctrl+X then Y then Enter${nc}"

# nano /usr/local/etc/apache24/httpd.conf

# Adding stuff to above file to get phpmyadmin working.

echo '<FilesMatch "\.php$">' >> /usr/local/etc/apache24/httpd.conf
echo '    SetHandler application/x-httpd-php' >> /usr/local/etc/apache24/httpd.conf
echo '</FilesMatch>' >> /usr/local/etc/apache24/httpd.conf
echo '<FilesMatch "\.phps$">' >> /usr/local/etc/apache24/httpd.conf
echo '    SetHandler application/x-httpd-php-source' >> /usr/local/etc/apache24/httpd.conf
echo '</FilesMatch>' >> /usr/local/etc/apache24/httpd.conf
echo ' ' >> /usr/local/etc/apache24/httpd.conf
echo 'Alias /phpMyAdmin "/usr/local/www/phpMyAdmin"' >> /usr/local/etc/apache24/httpd.conf
echo ' ' >> /usr/local/etc/apache24/httpd.conf
echo '<Directory "/usr/local/www/phpMyAdmin">' >> /usr/local/etc/apache24/httpd.conf
echo 'Options None' >> /usr/local/etc/apache24/httpd.conf
echo 'AllowOverride None' >> /usr/local/etc/apache24/httpd.conf
echo 'Require all granted' >> /usr/local/etc/apache24/httpd.conf
echo '</Directory>' >> /usr/local/etc/apache24/httpd.conf

service apache24 restart

# -------------------------------------------------------
# phpMyAdmin

echo " "
echo -e "${sep}"
echo -e "${msg}   Now for phpMyAdmin${nc}"
echo -e "${msg}   This may seem confusing but follow the steps closely${nc}"
echo -e "${msg}   and you shouldn't run in to any issues!${nc}"
echo -e "${sep}"
echo " "

phpmyadmin

# -------------------------------------------------------
# Now restart Apache, MySQL too for good measure.

echo " "
echo -e "${sep}"
echo -e "${msg}   Last step! Restart apache and mysql.${nc}"
echo -e "${msg}   Reminder: You can safely ignore the AH00557 & AH00558 errors.${nc}"
echo -e "${sep}"
echo " "

service apache24 restart
service mysql-server restart

echo " "
echo -e "${sep}"
echo -e "${msg} It looks like we finished here!!! NICE${nc}"
echo -e "${msg} Now when you have an app that requires a mysql${nc}"
echo -e "${msg} you can use this jails ip in the host setting${nc}"
echo " "
echo -e "${msg} You can also head to ${url}http://yourjailip/phpMyAdmin${nc}"
echo -e "${msg} enter root for the username and use the password you set earlier${nc}"
echo -e "${msg} to easily create/modify/etc. your new mysql database!${nc}"
echo " "
echo -e " More information will be added to this script later"
echo -e " And will also be added to a forum post somewhere."
echo " "
echo -e "${msg} You can get in touch with me any of the ways listed here:${nc}"
echo -e "${url} http://vengefulsyndicate.com/about-us${nc}"
echo -e "${sep}"
echo " "

}

#------------------------------------------------------------------------------#
### OWNCLOUD INSTALL

install.cloud ()
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

trusteddomain.error ()
{
# Confirm with the user
echo " "
echo -e "${emp} Please finish the owncloud setup before continuing${nc}"
echo -e "${msg} Head to ${url}https://$cloud_server_ip:$cloud_server_port ${msg}to do this.${nc}"
echo -e "${msg} Fill out the page you are presented with and hit finish${nc}"
echo " "
echo -e "${msg} Admin username & password = whatever you choose${nc}"
echo " "
echo -e "${emp} Make sure you click 'Storage & database'${nc}"
echo " "
echo -e "${msg} Database user = ${qry}root${nc} | Database password = ${nc}"
echo -e "${msg} the ${qry}mysql password${msg} you chose earlier during the script.${nc}"
echo -e "${msg} Database name = your choice (just ${qry}owncloud${msg} is fine)${nc}"
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
              echo "    '${server_ip}'," >> /usr/local/www/owncloud/config/trusted.txt
              cat "/usr/local/www/owncloud/config/old_config.bak" | \
                sed '8r /usr/local/www/owncloud/config/trusted.txt' > \
                "/usr/local/www/owncloud/config/config.php"
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

echo " "
echo -e "${sep}"
echo -e "${msg}   Welcome to the ownCloud installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's get to installing some stuff!!${nc}"
echo -e "${sep}"
echo " "

# Install packages
pkg install -y lighttpd php56-openssl php56-ctype php56-curl php56-dom php56-fileinfo php56-filter php56-gd php56-hash php56-iconv php56-json php56-mbstring php56-mysql php56-pdo php56-pdo_mysql php56-pdo_sqlite php56-session php56-simplexml php56-sqlite3 php56-xml php56-xmlrpc php56-xmlwriter php56-xmlreader php56-gettext php56-mcrypt php56-zip php56-zlib php56-posix mp3info mysql56-server pecl-apcu

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
	sed -r '/^var.server_root/s|"(.*)"|"/usr/local/www/owncloud"|' | \
	sed -r '/^server.use-ipv6/s|"(.*)"|"disable"|' | \
	sed -r '/^server.document-root/s|"(.*)"|"/usr/local/www/owncloud"|' | \
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
echo -e "${msg} Creating www folder and downloading ownCloud${nc}"
echo -e "${sep}"
echo " "

mkdir -p /usr/local/www
# Get ownCloud, extract it, copy it to the webserver
# and have the jail assign proper permissions
cd "/tmp"
fetch "https://download.owncloud.org/community/owncloud-${owncloud_version}.tar.bz2"
tar xf "owncloud-${owncloud_version}.tar.bz2" -C /usr/local/www
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

echo " "
echo -e "${sep}"
echo -e "${msg} Now to finish owncloud setup${nc}"
echo -e "${sep}"
echo " "

trusteddomain.error

echo " "
echo -e "${sep}"
echo -e "${msg} It looks like we finished here!!! NICE${nc}"
echo -e "${msg} Now you can head to ${url}https://$cloud_server_ip:$cloud_server_port${nc}"
echo -e "${msg} to use your owncloud whenever you wish!${nc}"
echo " "
echo " "
echo " "
echo -e "${emp} Memory Caching ${msg}will have to be enabled manually.${nc}"
echo -e "${msg} This is entirely optional. Head to this file:${nc}"
echo -e "\033[1;36m    /usr/local/www/owncloud/config/config.php${nc} ${msg}and add:${nc}"
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

}

#------------------------------------------------------------------------------#
### EMBY SERVER INSTALL

install.emby ()
{
# Install via packages
pkg install -y emby-server
# Enable automatic startup of Emby Server
sysrc emby_server_enable="YES"
# Start the Emby Server
service emby-server start
}

#------------------------------------------------------------------------------#
### SONARR INSTALL

install.sonarr ()
{
# Taken from Sonarr install script (In jail + root user version)
# Version 1.00 (March 15, 2016)
# This is for installations that followed the documented FreeBSD installation
# You can find this information here: https://github.com/Sonarr/Sonarr/wiki/FreeBSD-installation
# This can be used temporarily for when Built-In update mechanism fails or in place of it enitrely.

echo " "
echo -e "${sep}"
echo "   Sonarr Install Script"
echo -e "${sep}"
echo " "

echo " "
echo -e "${sep}"
echo "   Let's start with installing Sonarr from packages"
echo -e "${sep}"
echo " "

pkg install -y sonarr

# Remove ffmpeg

# Build from ports tree # TODO: Add instructions on how

# Install new ffmpeg

# Start sonarr
service sonarr start

# TODO: Direct user to sonarr
}

#------------------------------------------------------------------------------#
### COUCHPOTATO INSTALL

install.couchpotato ()
{
#Install required tools
pkg install python py27-sqlite3 fpc-libcurl docbook-xml git-lite

#For default install location and running as root
cd /usr/local

#If running as root, expects python here
ln -s /usr/local/bin/python /usr/bin/python

#get couchpotato from git
git clone https://github.com/CouchPotato/CouchPotatoServer.git

#Copy the startup script
cp CouchPotatoServer/init/freebsd /usr/local/etc/rc.d/couchpotato

#Make startup script executable
chmod 555 /usr/local/etc/rc.d/couchpotato

#Add startup to boot
echo 'couchpotato_enable="YES"' >> /etc/rc.conf

#Read the options at the top of more /usr/local/etc/rc.d/couchpotato
#If not default install, specify options with startup flags in ee /etc/rc.conf
#Finally,

service couchpotato start
#Open your browser and go to: http://server:5050/
}

#------------------------------------------------------------------------------#
### HEADPHONES INSTALL

install.headphones ()
{
# Headphones Installation (Covers Music)
git clone https://github.com/rembo10/headphones.git

#Copy the startup script
# cp headphones/init-scripts/init.freebsd /usr/local/etc/rc.d/headphones
#Fetch Nostalgist92's startup script instead

#Make startup script executable
chmod 555 /usr/local/etc/rc.d/headphones

#Add startup to boot
echo 'headphones_enable="YES"' >> /etc/rc.conf

#Start the server
service headphones start

#Open your browser and go to: http://server:headphonesport?/
}



################################################################################
##### UPDATERS
# TODO: Start working on all applicable updaters
################################################################################

#------------------------------------------------------------------------------#
### MYSQL UPDATE

update.mysql ()
{
echo -e "${emp} This part of the script is unfinished currently :("
echo " "
}

#------------------------------------------------------------------------------#
### OWNCLOUD UPDATE

update.cloud ()
{
echo -e "${emp} This part of the script is unfinished currently :("
echo " "
}

#------------------------------------------------------------------------------#
### EMBY SERVER UPDATE

update.emby ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's start with a backup.${nc}"
echo -e "${msg}   First, make sure we have rsync and then${nc}"
echo -e "${msg}   we will use it to create a backup${nc}"
echo -e "${sep}"
echo " "

# Using rsync rather than cp so we can see progress actually happen on the backup for large servers.
pkg install -y rsync

echo " "
echo -e "${sep}"
echo " "

echo -e "${emp} Application backup${nc}"
mkdir -p /usr/local/lib/emby-server-backups/${date} # Using -p in case you've never run the script before or you have deleted this folder
rsync -a --info=progress2 /usr/local/lib/emby-server/ /usr/local/lib/emby-server-backups/${date}
echo -e "${fin}    Application backup done..${nc}"

echo " "

echo -e "${emp} Server data backup ${inf}(May take a while)${nc}"
mkdir -p /var/db/emby-server-backups/${date}
rsync -a --info=progress2 /var/db/emby-server/ /var/db/emby-server-backups/${date}
echo -e "${fin}    Server backup done.${nc}"

echo " "
echo -e "${sep}"
echo -e "${msg}   Grab the update${nc}"
echo -e "${sep}"
echo " "

fetch --no-verify-peer -o /tmp/emby-${embyver}.zip https://github.com/MediaBrowser/Emby/releases/download/${embyver}/Emby.Mono.zip

echo " "
echo -e "${sep}"
echo -e "${msg} Download done, let's stop the server${nc}"
echo -e "${sep}"
echo " "

service emby-server stop

echo " "
echo -e "${sep}"
echo -e "${msg} Now to extract the download and replace old version${nc}"
echo -e "${sep}"
echo " "

unzip -o "/tmp/emby-${embyver}.zip" -d /usr/local/lib/emby-server

echo " "
echo -e "${sep}"
echo -e "${msg} And finally, start the server back up.${nc}"
echo -e "${sep}"
echo " "

service emby-server start

echo " "
echo -e "${sep}"
echo -e "${msg} That should be it!${nc}"
echo -e "${msg} Now head to your Emby dashboard to ensure it's up to date.${nc}"
echo -e "${msg} (Refresh the page if you already have Emby open)${nc}"
echo " "
echo " "
echo " "
echo -e "${msg} If something went wrong you can do the following to restore the old version:${nc}"
echo -e "${cmd}   rm -r /usr/local/lib/emby-server${nc}"
echo -e "${cmd}   mv /usr/local/lib/emby-server-backups/${date} /usr/local/lib/emby-server${nc}"
echo " "
echo -e "${msg} And use this to restore your server database/settings:${nc}"
echo -e "${cmd}   rm -r /var/db/emby-server${nc}"
echo -e "${cmd}   mv /var/db/emby-server-backups/${date} /var/db/emby-server${nc}"
echo -e "${sep}"
echo " "
echo -e "${msg} You can get in touch with me any of the ways listed here:${nc}"
echo -e "${url} http://vengefulsyndicate.com/about-us${nc}"
echo -e "${msg}      Happy Streaming!${nc}"
echo " "
echo -e "${sep}"
echo " "
}

#------------------------------------------------------------------------------#
### EMBY SERVER UPDATE (SAFE METHOD)

update.emby.safe ()
{
pkg update
pkg upgrade emby-server
}

#------------------------------------------------------------------------------#
### SONARR UPDATE

update.sonarr ()
{
# Would user like automatic script?
# If yes, fetch from github or [VS] website.
# Guide user through steps
# Proceed to use following update steps for now

# Sonarr update script
# Version 2.0.1 (March 17, 2016)

echo " "
echo -e "${sep}"
echo "   Sonarr Update Script"
echo -e "${sep}"
echo " "

echo " "
echo -e "${sep}"
echo "   Let's start with downloading the update"
echo -e "${sep}"
echo " "

cd /tmp
fetch http://download.sonarr.tv/v2/master/mono/NzbDrone.master.tar.gz

echo " "
echo -e "${sep}"
echo "   Deleting any old updates & extracting files"
echo -e "${sep}"
echo " "

rm -r /tmp/sonarr_update
tar xvfz NzbDrone.master.tar.gz
mv /tmp/NzbDrone /tmp/sonarr_update

echo " "
echo -e "${sep}"
echo "   Shutting down Sonarr"
echo -e "${sep}"
echo " "

service sonarr stop

echo " "
echo -e "${sep}"
echo "   Backing up config and database"
echo -e "${sep}"
echo " "

mkdir /tmp/sonarr_backup
cp /usr/local/sonarr/nzbdrone.db /tmp/sonarr_backup/nzbdrone.db-${backupdate}
cp /usr/local/sonarr/config.xml /tmp/sonarr_backup/config.xml-${backupdate}
mv /tmp/nzbdrone_update /tmp/sonarr_update

echo " "
echo -e "${sep}"
echo "   Renaming old sonarr folder & copying new"
echo "   Setting permissions while we are at it"
echo -e "${sep}"
echo " "

mkdir /usr/local/share/sonarr.backups
mv /usr/local/share/sonarr /usr/local/share/sonarr.backups/manualupdate-${backupdate}
mv /tmp/sonarr_update/NzbDrone /usr/local/share/sonarr
chown -R 351:0 /usr/local/share/sonarr/
chmod -R 755 /usr/local/share/sonarr/

echo " "
echo -e "${sep}"
echo "   Last second housecleaning"
echo -e "${sep}"
echo " "

rm /tmp/NzbDrone.master.tar.gz
rm -r /tmp/nzbdrone_backup
rm -r /tmp/sonarr_update

echo " "
echo -e "${sep}"
echo "   Starting up Sonarr"
echo -e "${sep}"
echo " "

service sonarr restart
}

#------------------------------------------------------------------------------#
### COUCHPOTATO UPDATE

update.couchpotato ()
{
echo -e "${emp} This part of the script is unfinished currently :("
echo " "
}



################################################################################
##### BACKUPS
# TODO: Start working on all applicable backups
################################################################################

#------------------------------------------------------------------------------#
### MYSQL BACKUP

backup.mysql ()
{
echo -e "${emp} This part of the script is unfinished currently :("
echo " "
}

#------------------------------------------------------------------------------#
### OWNCLOUD BACKUP

backup.cloud ()
{
echo -e "${emp} This part of the script is unfinished currently :("
echo " "
}

#------------------------------------------------------------------------------#
### EMBY SERVER BACKUP

backup.emby ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   First, make sure we have rsync and then${nc}"
echo -e "${msg}   we will use it to create a backup${nc}"
echo -e "${sep}"
echo " "

# Using rsync rather than cp so we can see progress actually happen on the backup for large servers.
pkg install -y rsync

echo " "
echo -e "${sep}"
echo " "

echo -e "${emp} Application backup${nc}"
mkdir -p /usr/local/lib/emby-server-backups/${date} # Using -p in case you've never run the script before or you have deleted this folder
rsync -a --info=progress2 /usr/local/lib/emby-server/ /usr/local/lib/emby-server-backups/${date}
echo -e "${fin}    Application backup done..${nc}"

echo " "

echo -e "${emp} Server data backup ${inf}(May take a while)${nc}"
mkdir -p /var/db/emby-server-backups/${date}
rsync -a --info=progress2 /var/db/emby-server/ /var/db/emby-server-backups/${date}
echo -e "${fin}    Server backup done.${nc}"

echo " "
echo -e "${sep}"
echo -e "${msg} That should be it!${nc}"
echo " "
echo " "
echo " "
echo -e "${msg} If something goes wrong you can do the following to restore an old version:${nc}"
echo -e "${cmd}   rm -r /usr/local/lib/emby-server${nc}"
echo -e "${cmd}   mv /usr/local/lib/emby-server-backups/${date} /usr/local/lib/emby-server${nc}"
echo " "
echo -e "${msg} And use this to restore your server database/settings:${nc}"
echo -e "${cmd}   rm -r /var/db/emby-server${nc}"
echo -e "${cmd}   mv /var/db/emby-server-backups/${date} /var/db/emby-server${nc}"
echo -e "${sep}"
echo " "
}

#------------------------------------------------------------------------------#
### SONARR BACKUP

backup.sonarr ()
{
echo -e "${emp} This part of the script is unfinished currently :("
echo " "
}

#------------------------------------------------------------------------------#
### COUCHPOTATO BACKUP

backup.couchpotato ()
{
echo -e "${emp} This part of the script is unfinished currently :("
echo " "
}

#------------------------------------------------------------------------------#
### HEADPHONES BACKUP

backup.headphones ()
{
echo -e "${emp} This part of the script is unfinished currently :("
echo " "
}



################################################################################
##### CONFIRMATIONS
# TODO: Add confirms for all installs as a safety thing
################################################################################

### INSTALL CONFIRMATIONS
#------------------------------------------------------------------------------#

#------------------------------------------------------------------------------#
### MYSQL CONFIRM INSTALL

confirm.mysql.install ()
{
# Confirm with the user
read -r -p "   Confirm Installation of MySQL? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.mysql
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### OWNCLOUD CONFIRM INSTALL

confirm.cloud.install ()
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
              echo -e "${alt} Stopping script..${nc}"
              echo " "
              echo -e "${sep}"
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

echo " "
echo -e "${msg} Checking to see if you need to modify the script${nc}"
echo -e "${msg} If ${emp}ANY${msg} of these ${emp}DON'T${msg} match YOUR setup, answer with ${emp}no${nc}."
echo -e " "
echo -e "      ${alt}#1: ${msg}Is this your jails IP? ${qry}$cloud_server_ip${nc}"
echo -e "      ${alt}#2: ${msg}Is this the port you want to use? ${qry}$cloud_server_port${nc}"
echo -e "      ${alt}#3: ${msg}Is this the ownCloud version you want to install? ${qry}$owncloud_version${nc}"
echo -e " "
echo -e "${emp} If #1 or #2 are incorrect you will encounter issues!${nc}"

confirm

echo " "
echo -e "${fin} Awesome, now we are ready to get on with it!${nc}"
# Confirm with the user
echo -e "${inf} Final confirmation before installing owncloud.${nc}"
read -r -p "   Confirm Installation of OwnCloud? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.cloud
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo -e "${sep}"
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### EMBY SERVER CONFIRM INSTALL

confirm.emby.install ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Emby Media Server? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.emby
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### SONARR CONFIRM INSTALL

confirm.sonarr.install ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Sonarr? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.sonarr
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### COUCHPOTATO CONFIRM INSTALL

confirm.couchpotato.install ()
{
# Confirm with the user
read -r -p "   Confirm Installation of CouchPotato? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.couchpotato
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### HEADPHONES CONFIRM INSTALL

confirm.headphones.install ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Headphones? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.headphones
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### UPDATE CONFIRMATIONS
# TODO: Add run backup before update commands + inform the user of backup
#------------------------------------------------------------------------------#

### MYSQL CONFIRM UPDATE
#------------------------------------------------------------------------------#

confirm.mysql.update ()
{
# Confirm with the user
read -r -p "   Confirm Update of MySQL? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.mysql
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### OWNCLOUD CONFIRM UPDATE

confirm.cloud.update ()
{
# Confirm with the user
read -r -p "   Confirm Update of OwnCloud? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.cloud
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### EMBY SERVER CONFIRM UPDATE (SAFE METHOD)

confirm.emby.update.safe ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Emby Server updater (Safe method)${nc}"
echo -e "${sep}"
echo " "
echo -e "${emp} NOTE: This update method will not always be the very${nc}"
echo -e "${emp} latest version as BSD packages are updated slower${nc}"
echo -e "${emp} but this method won't break anything.${nc}"
echo " "
echo -e "${msg} Only continue if you are 100% sure${nc}"
echo -e "${inf} (Will also do a backup)${nc}"
# Confirm with the user
read -r -p "   Confirm Update of Emby Media Server? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.emby.safe
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
echo " "
echo " "
}

#------------------------------------------------------------------------------#
### EMBY SERVER CONFIRM UPDATE (SAFE METHOD)

confirm.emby.update.safe ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Emby Server updater (Latest method)${nc}"
echo -e "${sep}"
echo " "
echo -e "${emp} CAUTION: This will remove the ability to restart your${nc}"
echo -e "${emp}          Emby Server via the web dashboard!${nc}"
echo " "
echo -e "${msg} If you need to restart the server, you can with:${nc}"
echo -e "${cmd}    service emby-server restart${nc}"
echo " "
echo -e "${qry} Reminder${msg}: make sure you have modified the 'embyver'${nc}"
echo -e "${msg} line at the top of this script to the latest version.${nc}"
echo " "
echo -e "${msg} Only continue if you are 100% sure${nc}"
echo -e "${inf} (Will also do a backup)${nc}"
# Confirm with the user
read -r -p "   Confirm Update of Emby Media Server? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.emby
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
echo " "
echo " "
}

#------------------------------------------------------------------------------#
### SONARR CONFIRM UPDATE

confirm.sonarr.update ()
{
# Confirm with the user
read -r -p "   Confirm Update of Sonarr? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.sonarr
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### COUCHPOTATO CONFIRM UPDATE

confirm.couchpotato.update ()
{
# Confirm with the user
read -r -p "   Confirm Update of CouchPotato? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.couchpotato
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### HEADPHONES CONFIRM UPDATE

confirm.headphones.update ()
{
# Confirm with the user
read -r -p "   Confirm Update of Headphones? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.headphones
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}



################################################################################
##### SUBMENUS
# TODO: Add appropriate commands to backups option once finished
################################################################################

### MYSQL SUBMENU
#------------------------------------------------------------------------------#

mysql.submenu ()
{
while [ "$choice" != "m" ]
do
        echo -e "${fin} MySQL + phpMyAdmin${nc}"
        echo
        echo -e "${qry} Choose one:"
        echo " "
        echo -e "${fin}   1)${msg} Install"
        echo -e "${fin}   2)${msg} Update"
        echo -e "${fin}   3)${msg} Backup"
        echo -e "${emp}   m) Main Menu${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"

        case $choice in
            '1') echo -e "${inf} Installing..${nc}"
                confirm.mysql.install
                ;;
            '2') echo -e "${inf} Running Update..${nc}"
                confirm.mysql.update
                ;;
            '3') echo -e "${inf} Backup..${nc}"
                backup.mysql
                ;;
            'm') return
                ;;
        esac
done
}

#------------------------------------------------------------------------------#
### OWNCLOUD SUBMENU

cloud.submenu ()
{
while [ "$choice" != "h,i,m" ]
do
        echo -e "${sep}"
        echo -e "${fin} OwnCloud Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:"
        echo " "
        echo -e "${fin}   1)${msg} Install"
        echo -e "${fin}   2)${msg} Update"
        echo -e "${fin}   3)${msg} Backup"
        echo " "
        echo -e "${fin}   4)${msg} Fix Known Errors${nc}"
        echo -e "${fin}   5)${msg} Other${nc}"
        echo " "
        echo -e "${inf}  i) More Info / How-To's${nc}"
        echo -e "${inf}  h) Get Help${nc}"
        echo -e "${emp}  m) Main Menu${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"

        case $choice in
            '1') echo -e "${inf} Installing..${nc}"
                confirm.cloud.install
                ;;
            '2') echo -e "${inf} Running Update..${nc}"
                confirm.cloud.update
                ;;
            '3') echo -e "${inf} Backup..${nc}"
                backup.cloud
                ;;
            '4')
                cloud.errorfix.submenu
                ;;
            '5')
                cloud.otheroptions.menu
                ;;
            'i')
                moreinfo.submenu
                ;;
            'h')
                gethelp
                ;;
            'm') return
                ;;
            *)   echo -e "${emp}        Invalid choice, please try again${nc}"
                ;;
        esac
done
}

### ERROR FIXES SUBMENU
#------------------------------------------------------------------------------#

cloud.errorfix.submenu ()
{
while [ "$choice" != "b" ]
do
        echo -e "${sep}"
        echo -e "${inf} OwnCloud - Fixes For Known Errors${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:"
        echo " "
        echo -e "${fin}   1)${msg} Trusted Domain Error"
        echo -e "${fin}   2)${msg} Populating Raw Post Data Error"
        echo " "
        echo -e "${emp}   b) Back${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"

        case $choice in
            '1') echo -e "${inf} ${nc}"
                cloud.trusteddomain.fix
                ;;
            '2') echo -e "${inf} ${nc}"
                cloud.phpini
                ;;
            'b') return
                ;;
        esac
done
}

#------------------------------------------------------------------------------#
### EMBY SERVER SUBMENU

emby.submenu ()
{
while [ "$choice" != "m" ]
do
        echo -e "${fin} Emby Options${nc}"
        echo
        echo -e "${qry} Choose one:"
        echo " "
        echo -e "${fin}   1)${msg} Install${nc}"
        echo -e "${fin}   2)${msg} Update via Packages ${inf}(Safe)${nc}"
        echo -e "${fin}   3)${msg} Update via GitHub ${inf}(More Up To Date)${nc}"
        echo -e "${fin}   4)${msg} Backup${nc}"
        echo " "
        echo -e "${alt}  m) Main Menu${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"

        case $choice in
            '1') echo -e "${inf} Installing..${nc}"
                confirm.emby.install
                ;;
            '2') echo -e "${inf} Running Update..${nc}"
                confirm.emby.update.safe
                ;;
            '3') echo -e "${inf} Running Update..${nc}"
                confirm.emby.update.git
                ;;
            '4') echo -e "${inf} Backup..${nc}"
                backup.emby
                ;;
            'm') return
                ;;
        esac
done
}

#------------------------------------------------------------------------------#
### SONARR SUBMENU

sonarr.submenu ()
{
while [ "$choice" != "m" ]
do
        echo -e "${fin} Sonarr Options${nc}"
        echo
        echo -e "${qry} Choose one:"
        echo " "
        echo -e "${fin}   1)${msg} Install"
        echo -e "${fin}   2)${msg} Update"
        echo -e "${fin}   3)${msg} Backup"
        echo -e "${emp}   m) Main Menu${nc}"

        echo -e "${ssep}"
        read choice
        echo -e "${ssep}"

        case $choice in
            '1') echo -e "${inf} Installing..${nc}"
                confirm.sonarr.install
                ;;
            '2') echo -e "${inf} Running Update..${nc}"
                confirm.sonarr.update
                ;;
            '3') echo -e "${inf} Backup..${nc}"
                backup.sonarr
                ;;
            'm') return
                ;;
        esac
done
}

#------------------------------------------------------------------------------#
### COUCHPOTATO SUBMENU

couchpotato.submenu ()
{
while [ "$choice" != "m" ]
do
        echo -e "${fin} CouchPotato Options${nc}"
        echo
        echo -e "${qry} Choose one:"
        echo " "
        echo -e "${fin}   1)${msg} Install"
        echo -e "${fin}   2)${msg} Update"
        echo -e "${fin}   3)${msg} Backup"
        echo -e "${emp}   m) Main Menu${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"

        case $choice in
            '1') echo -e "${inf} Installing..${nc}"
                confirm.couchpotato.install
                ;;
            '2') echo -e "${inf} Running Update..${nc}"
                confirm.couchpotato.update
                ;;
            '3') echo -e "${inf} Backup..${nc}"
                backup.couchpotato
                ;;
            'm') return
                ;;
        esac
done
}

#------------------------------------------------------------------------------#
### HEADPHONES SUBMENU

headphones.submenu ()
{
while [ "$choice" != "m" ]
do
        echo -e "${fin} HeadPhones Options${nc}"
        echo
        echo -e "${qry} Choose one:"
        echo " "
        echo -e "${fin}   1)${msg} Install"
        echo -e "${fin}   2)${msg} Update"
        echo -e "${fin}   3)${msg} Backup"
        echo -e "${emp}   m) Main Menu${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"

        case $choice in
            '1') echo -e "${inf} Installing..${nc}"
                confirm.headphones.install
                ;;
            '2') echo -e "${inf} Running Update..${nc}"
                confirm.headphones.update
                ;;
            '3') echo -e "${inf} Backup..${nc}"
                backup.headphones
                ;;
            'm') return
                ;;
        esac
done
}



#------------------------------------------------------------------------------#
### MORE INFORMATION / HOW-TO / FURTHER INSCTRUCTIONS SUBMENU (COMBINED)

moreinfo.submenu ()
{
while [ "$choice" != "b" ]
do
        echo -e "${sep}"
        echo -e "${inf} More Info / How-To's Menu"
        echo -e "${sep}"
        echo -e "${qry} Choose one:"
        echo " "
        echo -e "${msg} How to..."
        echo -e "${fin}   1)${msg} TheBrig - Create a jail"
        echo -e "${fin}   2)${msg} OwnCloud - Finish the owncloud setup"
        echo " "
        echo -e "${emp}   b) Back${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"

        case $choice in
            '1') thebrig.createajail
                ;;
            '2') cloud.howtofinishsetup
                ;;
            'b') return
                ;;
        esac
done
}



#------------------------------------------------------------------------------#
### MORE INFORMATION / HOW-TO / FURTHER INSCTRUCTIONS SUBMENU (SPECIFIC)
# YAY OR NAY?

moreinfo.submenu.cloud ()
{

}



#------------------------------------------------------------------------------#
### OWNCLOUD OTHER OPTIONS SUBMENU

cloud.otheroptions.menu ()
{
while [ "$choice" != "b" ]
do
        echo -e "${sep}"
        echo -e "${inf} OwnCloud - Other Options"
        echo -e "${sep}"
        echo -e "${qry} Choose one:"
        echo " "
        echo -e "${fin}   1)${msg} Enable Memory Caching"
        echo " "
        echo -e "${emp}   b) Back${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"

        case $choice in
            '1') echo -e "${inf} Enabling Memory Caching..${nc}"
                cloud.enablememcache
                ;;
            'b') return
                ;;
        esac
done
}



################################################################################
##### MAIN MENU
################################################################################

mainmenu=""

while [ "$choice" != "q,h,i" ]
do
        echo -e "${sep}"
        echo -e "${inf} AIO Script - Version: 1.0.3 (March 28, 2016) by Nozza"
        echo -e "${sep}"
        echo -e "${emp} Main Menu"
        echo " "
        echo -e "${qry} Please make a selection!"
        echo " "
        echo -e "${fin}   1)${msg} MySQL + phpMyAdmin${nc}"
        echo -e "${fin}   2)${msg} OwnCloud${nc}"
        echo -e "${fin}   3)${msg} Emby Server${nc}"
        echo -e "${fin}   4)${msg} Sonarr${nc}"
        echo -e "${fin}   5)${msg} CouchPotato${nc}"
        echo -e "${fin}   6)${msg} HeadPhones${nc}"
        echo " "
        echo -e "${inf}  h) Contact / Get Help${nc}"
        echo -e "${inf}  i) More Info / How-To's${nc}"
        echo -e "${alt}  q) Quit${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"

        case $choice in
            '1')
                mysql.submenu
                ;;
            '2')
                cloud.submenu
                ;;
            '3')
                emby.submenu
                ;;
            '4')
                sonarr.submenu
                ;;
            '5')
                couchpotato.submenu
                ;;
            '6')
                headphones.submenu
                ;;
            'i')
                moreinfo.submenu
                ;;
            'h')
                gethelp
                ;;
            'q') echo -e "${alt}        Exiting script!${nc}"
                echo " "
                ;;
            *)   echo -e "${emp}        Invalid choice, please try again${nc}"
                ;;
        esac
done

# FUTURE: Add "TheBrig guided install"
# FUTURE: When jail creation via shell is possible for thebrig, will add that option to script.
# FUTURE: Add "Calibre"
# FUTURE: Add "Deluge"
# FUTURE: Add "Mail Server"
# FUTURE: Add "Munin"
# FUTURE: Add "Plex"
# FUTURE: Add "Pydio"
# FUTURE: Add "Serviio"
# FUTURE: Add "SqueezeBox"
# FUTURE: Add "Subsonic"
# FUTURE: Add "UMS"
# FUTURE: Add "Web Server"

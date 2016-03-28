#!/bin/sh
# OwnCloud Script - Version: 2.0.3 (March 28, 2016)
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
server_port="81"
server_ip="192.168.1.200"
owncloud_version="9.0.0"
### No need to edit below here ###
### Any modifications made below here are done at your own risk ###
##### END OF CONFIGURATION SECTION #####
################################################################################


#####
###
#  This is a simple script to automate the installation of OwnCloud within a
#  jailed environment. Also included is a backup, update and fix options for
#  any known issues/features.
###
#####


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

# define our bail out shortcut function anytime there is an error - display
# the error message, then exit returning 1.
exerr () { echo -e "$*" >&2 ; exit 1; }



## Begin sanity checks
# None, as this script is intended to be run from the command line
## End sanity checks



################################################################################
##### INSTALLERS
# TODO: Test
################################################################################


installcloud ()
{

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

echo -e "${msg} Head to ${url}https://$server_ip:$server_port ${msg}and fill out the${nc}"
echo -e "${msg} appropriate information. If you are unsure what to do,${nc}"
echo -e "${msg} go back to the main menu and select 'More Info'${nc}"

echo -e "${sep}"
echo -e "${msg} Looks like we are done here!!! Now you can head to${nc}"
echo -e "${url}    https://$server_ip:$server_port ${msg}to use your owncloud!${nc}"
echo " "
echo -e "${emp} Memory Caching ${msg}is currently disabled by default.${nc}"
echo -e "${msg}    Head back to the main menu to enable it.${nc}"
echo " "
echo -e "${msg} If you need any help, visit the forums here:${nc}"
echo -e "${url} http://forums.nas4free.org/viewtopic.php?f=79&t=9383${nc}"
echo -e "${sep}"
}

################################################################################
##### CONTACT
################################################################################

help ()
{
while [ "$choice" ]
do
        echo -e "${inf} Ways of contacting me / getting help from others:${nc}"
        echo " "
        echo -e "${fin}   My Discord Support (Usually faster responses):${nc}"
        echo -e "${msg}      https://discord.gg/0bXnhqvo189oM8Cr${nc}"
        echo -e "${fin}   My Email (Might add this later, Discord is easier though):${nc}"
        echo -e "${msg}      myemail@domain.com${nc}"
        echo -e "${fin}   Forums:${nc}"
        echo -e "${msg}      NAS4Free Forums:${nc}"
        echo -e "${url}      http://forums.nas4free.org/viewtopic.php?f=79&t=9383${nc}"
        echo -e "${msg}      VS Forums:${nc}"
        echo -e "${url}      forums.vengefulsyndicate.com${nc}"
        echo " "
        echo -e "${emp}   Press Enter To Go Back To The Main Menu${nc}"

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

enablememcache ()
{
echo -e "${msg} This part of the script is unfinished currently :("
#echo -e "${msg} This is entirely optional. Head to this file:${nc}"
#echo -e "\033[1;36m    /usr/local/www/owncloud/config/config.php${nc} ${msg}and add:${nc}"
#echo -e "\033[1;33m    'memcache.local' => '\OC\Memcache\APCu',${nc}"
#echo -e "${msg} right above the last line.${nc}"
#echo -e "${msg} Once you've edited this file, restart the server with:${nc}"
#/usr/local/etc/rc.d/lighttpd restart
}

howtofinishsetup ()
{
echo " "
echo -e "${emp} Follow these instructions carefully"
echo " "
echo -e "${msg} In a web browser, head to: ${url}https://$server_ip:$server_port${nc}"
echo " "
echo -e "${msg} Admin Username: Enter your choice of username${nc}"
echo -e "${msg} Admin Password: Enter your choice of password${nc}"
echo " "
echo -e "${alt}    Click Database options and choose MySQL${nc}"
echo -e "${msg} Database username: root${nc}"
echo -e "${msg} Database password: THE PASSWORD YOU ENTERED EARLIER FOR MYSQL${nc}"
echo -e "${msg} Database host: Leave as is (Should be localhost)${nc}"
echo -e "${msg} Database name: Your choice (owncloud is fine)${nc}"
echo " "
echo -e "${emp} Click Finish Setup, the page will take a moment to refresh${nc}"
echo -e "${msg} After it refreshes, if you are seeing a 'Trusted Domain' error,${nc}"
echo -e "${msg} Head back to the scripts main menu and select option 4.${nc}"
echo " "
}



################################################################################
##### FIXES
################################################################################

trusteddomainfix ()
{
# Confirm with the user
echo " "
echo -e "${emp} Please finish the owncloud setup before continuing${nc}"
echo -e "${msg} Head to ${url}https://$server_ip:$server_port ${msg}to do this.${nc}"
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

phpini ()
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
##### UPDATERS
# TODO: Merge owncloud_update.sh in to this script.
################################################################################

updatecloud ()
{
echo -e "${emp} This part of the script is unfinished currently :("
}



################################################################################
##### BACKUPS
# TODO: Create backup script
################################################################################

backupcloud ()
{
echo -e "${emp} This part of the script is unfinished currently :("
}



################################################################################
##### SUBMENUS
################################################################################

### ERROR FIXES SUBMENU
#------------------------------------------------------------------------------#

errorfixsubmenu ()
{
while [ "$choice" != "q,m" ]
do
        echo -e "${qry} Choose one:"
        echo " "
        echo -e "${fin}   1)${msg} Trusted Domain Error"
        echo -e "${fin}   2)${msg} Populating Raw Post Data Error"
        echo " "
        echo -e "${emp}   m) Main Menu${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"

        case $choice in
            '1') echo -e "${inf} ${nc}"
                trusteddomainfix
                ;;
            '2') echo -e "${inf} ${nc}"
                phpini
                ;;
            'm') return
                ;;
        esac
done
}



#------------------------------------------------------------------------------#
### FOR OTHER OPTIONS SUCH AS ENABLING MEMORY CACHING
#------------------------------------------------------------------------------#

otheroptions ()
{
while [ "$choice" != "q,m" ]
do
        echo -e "${qry} Choose one:"
        echo " "
        echo -e "${fin}   1)${msg} Enable Memory Caching"
        echo " "
        echo -e "${emp}   m) Main Menu${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"

        case $choice in
            '1') echo -e "${inf} Enabling Memory Caching..${nc}"
                enablememcache
                ;;
            'm') return
                ;;
        esac
done
}



#------------------------------------------------------------------------------#
### MORE INFORMATION / HOW-TO / FURTHER INSCTRUCTIONS
#------------------------------------------------------------------------------#

moreinfo ()
{
while [ "$choice" != "q,m" ]
do
        echo -e "${qry} Choose one:"
        echo " "
        echo -e "${msg} How to..."
        echo -e "${fin}   1)${msg} Finish the owncloud setup"
        echo " "
        echo -e "${emp}   m) Main Menu${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"

        case $choice in
            '1') howtofinishsetup
                ;;
            'm') return
                ;;
        esac
done
}



################################################################################
##### CONFIRMATIONS
################################################################################

### INSTALL CONFIRMATIONS
#------------------------------------------------------------------------------#

confirminstallcloud ()
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

echo " "
echo -e "${msg} Checking to see if you need to modify the script${nc}"
echo -e "${msg} If ${emp}ANY${msg} of these ${emp}DON'T${msg} match YOUR setup, answer with ${emp}no${nc}."
echo -e " "
echo -e "      ${alt}#1: ${msg}Is this your jails IP? ${qry}$server_ip${nc}"
echo -e "      ${alt}#2: ${msg}Is this the port you want to use? ${qry}$server_port${nc}"
echo -e "      ${alt}#3: ${msg}Is this the ownCloud version you want to install? ${qry}$owncloud_version${nc}"
echo -e " "
echo -e "${emp} If #1 or #2 are incorrect you will encounter issues!${nc}"

confirm

echo " "
echo -e "${url} Awesome, now we are ready to get on with it!${nc}"
# Confirm with the user
echo -e "${inf} Final confirmation before installing owncloud.${nc}"
read -r -p "   Confirm Installation of OwnCloud? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              installcloud
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

confirmupdatecloud ()
{
# Confirm with the user
echo " Highly recommended to Backup first"
read -r -p "   Confirm Update of OwnCloud? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              updatecloud
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### BACKUP CONFIRMATIONS
#------------------------------------------------------------------------------#

confirmbackupcloud ()
{
# Confirm with the user
read -r -p "   Confirm Backup of OwnCloud? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              backupcloud
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}



################################################################################
##### MAIN MENU
################################################################################

mainmenu=""

while [ "$choice" != "q,i,h" ]
do
        echo -e "${sep}"
        echo -e "${inf} OwnCloud Script - Version: 2.0.3 (March 28, 2016)"
        echo -e "${sep}"
        echo -e "${emp} Main Menu"
        echo " "
        echo -e "${qry} Please make a selection!"
        echo " "
        echo -e "${fin}   1)${msg} Install${nc}"
        echo -e "${fin}   2)${msg} Update${nc}"
        echo -e "${fin}   3)${msg} Backup${nc}"
        echo " "
        echo -e "${fin}   4)${msg} Fix Known Errors${nc}"
        echo -e "${fin}   5)${msg} Other${nc}"
        echo " "
        echo -e "${inf}  i) More Info / How-To's${nc}"
        echo -e "${inf}  h) Get Help${nc}"
        echo -e "${alt}  q) Quit${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"

        case $choice in
            '1')
                confirminstallcloud
                ;;
            '2')
                confirmupdatecloud
                ;;
            '3')
                confirmbackupcloud
                ;;
            '4')
                errorfixsubmenu
                ;;
            '5')
                otheroptions
                ;;
            'i')
                moreinfo
                ;;
            'h')
                help
                ;;
            'q') echo -e "${alt}        Exiting script!${nc}"
                echo " "
                ;;
            *)   echo -e "${emp}        Invalid choice, please try again${nc}"
                ;;
        esac
done



#------------------------------------------------------------------------------#
### Todo / Changes:
#------------------------------------------------------------------------------#

# FUTURE: Merge with AIO script
# FUTURE: Add MySQL alternative setup options

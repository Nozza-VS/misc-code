#!/bin/sh
# Script Version: TESTING-1.0 (March 10, 2016)
#	Install script for Pydio, formerly AjaXplorer (Cloud service) in a jailed
#   environment. See http://forums.nas4free.org/viewtopic.php?f=79&t=9274 for more info.
#   Copyrighted 2016 by Ashley Townsend under the Beerware License.

pkg install -y nginx php56 php56-extensions php56-curl php56-gd php56-imap php56-mbstring php56-mcrypt php56-mysql php56-mysqli php56-openssl php56-pdo_mysql php56-zip php56-zlib php56-exif mysql56-server

# MySQL Setup
echo 'mysql_enable="YES"' >> /etc/rc.conf
service mysql-server start
mysql_secure_installation
mysql -u root -p
CREATE DATABASE pydiodb;
CREATE USER "pydio"@"localhost" IDENTIFIED BY "ChangeThisPassword";
GRANT ALL PRIVILEGES ON pydiodb.* TO "pydio"@"localhost";
FLUSH PRIVILEGES;
quit

#
touch /usr/local/etc/my.cnf
echo '# The MySQL Server Configuration' >> /usr/local/etc/my.cnf
echo '[mysqld]' >> /usr/local/etc/my.cnf
echo 'socket          = /tmp/mysql.sock' >> /usr/local/etc/my.cnf
echo ' ' >> /usr/local/etc/my.cnf
echo "# Don't listen on a TCP/IP port at all." >> /usr/local/etc/my.cnf
echo 'skip-networking' >> /usr/local/etc/my.cnf
echo 'skip-name-resolve' >> /usr/local/etc/my.cnf
echo ' ' >> /usr/local/etc/my.cnf
echo '#Expire binary logs after one day:' >> /usr/local/etc/my.cnf
echo 'expire_logs_days = 1' >> /usr/local/etc/my.cnf

# SSL Certificates setup
cd /usr/local/etc/nginx
openssl genrsa -des3 -out server.key 2048
openssl req -new -key server.key -out server.csr
openssl x509 -req -days 3650 -in server.csr -signkey server.key -out ssl-bundle.crt
cp server.key server.key.orig
openssl rsa -in server.key.orig -out server.key

# Configuring PHP:`
cp /usr/local/etc/php.ini-production /usr/local/etc/php.ini

# Edit /usr/local/etc/php.ini
# Find:
# output_buffering = 4096
# ;session.save_path = "/tmp"
# upload_max_filesize = 2M
# max_file_uploads = 20
# post_max_size = 8M
# ;date.timezone = America/Los_Angeles

# and change to:

# output_buffering = OFF
# session.save_path = "/tmp"
# upload_max_filesize = 20G
# max_file_uploads = 20000
# post_max_size = 20G
# date.timezone = "Europe/Amsterdam"

# Configuring PHP-FPM:
mv /usr/local/etc/php-fpm.conf /usr/local/etc/php-fpm.conf.backup
touch /usr/local/etc/php-fpm.conf
echo '[global]' >> /usr/local/etc/php-fpm.conf
echo 'pid = run/php-fpm.pid' >> /usr/local/etc/php-fpm.conf
echo ' ' >> /usr/local/etc/php-fpm.conf
echo '[PYDIO]' >> /usr/local/etc/php-fpm.conf
echo 'listen = /var/run/phph-fpm.socket' >> /usr/local/etc/php-fpm.conf
echo 'listen.owner = www' >> /usr/local/etc/php-fpm.conf
echo 'listen.group = www' >> /usr/local/etc/php-fpm.conf
echo 'listen.mode = 0666' >> /usr/local/etc/php-fpm.conf
echo ' ' >> /usr/local/etc/php-fpm.conf
echo 'listen.backlog = -1' >> /usr/local/etc/my.cnf
echo 'listen.allowed_clients = 127.0.0.1' >> /usr/local/etc/php-fpm.conf
echo ' ' >> /usr/local/etc/php-fpm.conf
echo 'user = www' >> /usr/local/etc/php-fpm.conf
echo 'group = www' >> /usr/local/etc/php-fpm.conf
echo ' ' >> /usr/local/etc/php-fpm.conf
echo 'pm = dynamic' >> /usr/local/etc/php-fpm.conf
echo 'pm.max_children = 5' >> /usr/local/etc/php-fpm.conf
echo 'pm.start_servers = 2' >> /usr/local/etc/php-fpm.conf
echo 'pm.min_spare_servers = 1' >> /usr/local/etc/php-fpm.conf
echo 'pm.max_spare_servers = 3' >> /usr/local/etc/php-fpm.conf
echo 'pm.max_requests = 500' >> /usr/local/etc/php-fpm.conf
echo ' ' >> /usr/local/etc/php-fpm.conf
echo 'env[HOSTNAME] = $HOSTNAME' >> /usr/local/etc/php-fpm.conf
echo 'env[PATH] = /usr/local/bin:/usr/bin:/bin' >> /usr/local/etc/php-fpm.conf
echo 'env[TMP] = /tmp' >> /usr/local/etc/php-fpm.conf
echo 'env[TMPDIR] = /tmp' >> /usr/local/etc/php-fpm.conf
echo 'env[TEMP] = /tmp' >> /usr/local/etc/php-fpm.conf

# Configure fastcgi_params
mv /usr/local/etc/nginx/fastcgi_params /usr/local/etc/nginx/fastcgi_params.backup
touch /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  QUERY_STRING       $query_string;' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  REQUEST_METHOD     $request_method;' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  CONTENT_TYPE       $content_type;' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  CONTENT_LENGTH     $content_length;' >> /usr/local/etc/nginx/fastcgi_params
echo ' ' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  SCRIPT_FILENAME    $document_root$fastcgi_script_name;' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  SCRIPT_NAME        $fastcgi_script_name;' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  REQUEST_URI        $request_uri;' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  DOCUMENT_URI       $document_uri;' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  DOCUMENT_ROOT      $document_root;' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  SERVER_PROTOCOL    $server_protocol;' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  HTTPS              $https if_not_empty;' >> /usr/local/etc/nginx/fastcgi_params
echo ' ' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  GATEWAY_INTERFACE  CGI/1.1;' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  SERVER_SOFTWARE    nginx/$nginx_version;' >> /usr/local/etc/nginx/fastcgi_params
echo ' ' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  REMOTE_ADDR        $remote_addr;' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  REMOTE_PORT        $remote_port;' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  SERVER_ADDR        $server_addr;' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  SERVER_PORT        $server_port;' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  SERVER_NAME        $server_name;' >> /usr/local/etc/nginx/fastcgi_params
echo ' ' >> /usr/local/etc/nginx/fastcgi_params
echo '# PHP only, required if PHP was built with --enable-force-cgi-redirect' >> /usr/local/etc/nginx/fastcgi_params
echo 'fastcgi_param  REDIRECT_STATUS    200;' >> /usr/local/etc/nginx/fastcgi_params

# Start PHP-FPM
service php-fpm start

# Configuring Nginx
mv /usr/local/etc/nginx/nginx.conf /usr/local/etc/nginx/nginx.conf.backup
fetch -o /usr/local/etc/nginx/nginx.conf http://url/nginx.conf.template
# Tell user to edit this file using nano
# Everything with the 3 hash symbols (###) should be changed to match your environment

# Download & Install Pydio
cd ~
fetch "http://downloads.sourceforge.net/project/ajaxplorer/pydio/stable-channel/6.2.2/pydio-core-6.2.2.tar.gz"
tar -xzvf pydio-*
mv pydio-core-6.x.x /usr/local/www/pydio
chown -R www:www /usr/local/www/pydio
chmod -R 770 /usr/local/www/pydio

# Explain to user what to do
# Search for "//define("AJXP_LOCALE", "en_EN.UTF-8");"
# Change to "define("AJXP_LOCALE", "en_US.UTF-8");"
nano /usr/local/www/pydio/conf/bootstrap_conf.php

# End of script
echo "With all that done, you should now be able to access Pydio at https://192.168.1.2:4443"
echo "(or whatever the IP address is of your web server)."
echo 'From there you will be greeted with the Pydio configuration page. On that page, start off by setting up “Admin access”.'
echo "From there, set a name, a display name, and a passphrase for the Administrator account."
echo 'Afterwards, go to "Global options" and choose "English" as the "Default Language".'
echo " "
echo "Then in the “Configurations storage” area, fill in the fields as follows:"
echo " "
echo "Storage Type: Database"
echo "Enable Notifications: Yes"
echo "Database: MySQL"
echo "Host: localhost"
echo "Database: pydiodb"
echo "User: pydio"
echo "Password: The password you chose earlier"
echo " "
echo "Next, click on “Try connecting to the database”. This will verify the connection between Pydio and the MySQL server."
echo "If the configuration is correct, you will have this message: “Connection established!”"
echo "Then you may click on “Install Pydio Now!”"
echo "Pydio is now setup and ready for you to login with the Administrator account."
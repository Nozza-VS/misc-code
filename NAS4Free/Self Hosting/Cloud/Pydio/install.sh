#------------------------------------------------------------------------------#
### PYDIO CONFIRM INSTALL

confirm.install.pydio ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Pydio? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.pydio
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}



#------------------------------------------------------------------------------#
### PYDIO INSTALL

install.pydio ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Pydio Install Script${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's start with installing the prerequisites${nc}"
echo -e "${sep}"
echo " "

pkg install nginx php70 php70-extensions php70-curl php70-gd php70-imap php70-mbstring php70-mcrypt php70-mysqli php70-openssl php70-pdo_mysql php70-zip php70-zlib mysql57-server

echo 'nginx_enable="YES"' >> /etc/rc.conf
echo 'php_fpm_enable="YES"' >> /etc/rc.conf
echo 'mysql_enable="YES"' >> /etc/rc.conf

echo " "
echo -e "${sep}"
echo -e "${msg}   Packages installed, configuring mysql${nc}"
echo -e "${sep}"
echo " "

#touch /usr/local/etc/my.cnf
echo '# The MySQL server configuration' >> /var/db/mysql/my.cnf
echo '[mysqld]' >> /var/db/mysql/my.cnf
echo 'socket          = /tmp/mysql.sock' >> /var/db/mysql/my.cnf
echo '' >> /var/db/mysql/my.cnf
echo '# Don't listen on a TCP/IP port at all.' >> /var/db/mysql/my.cnf
echo 'skip-networking' >> /var/db/mysql/my.cnf
echo 'skip-name-resolve' >> /var/db/mysql/my.cnf
echo '' >> /var/db/mysql/my.cnf
echo '#Expire binary logs after one day:' >> /var/db/mysql/my.cnf
echo 'expire_logs_days = 1' >> /var/db/mysql/my.cnf

service mysql-server start

mysql_secure_installation

#mysql -u root -e "create database ${pydio_database_name}";
mysql -u root -e "create database pydio";

# SSL Certificates setup
#cd /usr/local/etc/nginx
#openssl genrsa -des3 -out server.key 2048
#openssl req -new -key server.key -out server.csr
#openssl x509 -req -days 3650 -in server.csr -signkey server.key -out ssl-bundle.crt
#cp server.key server.key.orig
#openssl rsa -in server.key.orig -out server.key

cp /usr/local/etc/php.ini-production /usr/local/etc/php.ini

service php-fpm start

fetch "https://download.pydio.com/pub/core/archives/pydio-core-7.0.3.tar.gz"
tar -xzvf pydio-*

mv pydio-core-5.x.x /usr/local/www/pydio

chown -R www:www /usr/local/www/pydio
chmod -R 770 /usr/local/www/pydio

service nginx start

}

confirm.install.pydio
#------------------------------------------------------------------------------#
### COUCHPOTATO CONFIRM INSTALL

confirm.install.couchpotato ()
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
### COUCHPOTATO INSTALL

install.couchpotato ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   CouchPotato Installer${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's install required packages first${nc}"
echo -e "${sep}"
echo " "

pkg install python py27-sqlite3 fpc-libcurl docbook-xml git-lite

echo " "
echo -e "${sep}"
echo -e "${msg} Grab CouchPotato from github${nc}"
echo -e "${msg} CouchPotato will be installed to:${nc}"
echo -e "${inf}    /usr/local/CouchPotato${nc}"
echo -e "${sep}"
echo " "

#If running as root, expects python here
ln -s /usr/local/bin/python /usr/bin/python
git clone https://github.com/CouchPotato/CouchPotatoServer.git /usr/local/CouchPotato

echo " "
echo -e "${sep}"
echo -e "${msg} Copy startup script & make executable${nc}"
echo -e "${sep}"
echo " "

cp CouchPotatoServer/init/freebsd /usr/local/etc/rc.d/couchpotato
chmod +x /usr/local/etc/rc.d/couchpotato
chmod 555 /usr/local/etc/rc.d/couchpotato

echo " "
echo -e "${sep}"
echo -e "${msg} Enable CouchPotato at startup${nc}"
echo -e "${sep}"
echo " "

echo 'couchpotato_enable="YES"' >> /etc/rc.conf

#Read the options at the top of more /usr/local/etc/rc.d/couchpotato
#If not default install, specify options with startup flags in ee /etc/rc.conf
#Finally,

echo " "
echo -e "${sep}"
echo -e "${msg} Start CouchPotato${nc}"
echo -e "${sep}"
echo " "

service couchpotato start

echo " "
echo -e "${sep}"
echo -e "${msg} Open your browser and go to: ${url}yourjailip:5050${nc}"
echo -e "${msg} to finish setting up your CouchPotato server${nc}"
echo -e "${sep}"
echo " "

echo " "
echo -e "${sep}"
echo -e "${msg} Done here!${nc}"
echo -e "${msg} Feel free to visit the project homepage at:${nc}"
echo -e "${url}    https://github.com/CouchPotato/CouchPotatoServer${nc}"
echo -e "${url}    https://couchpota.to${nc}"
echo -e "${sep}"
echo " "

}

confirm.install.couchpotato
#------------------------------------------------------------------------------#
### ORGANIZR INSTALL

install.organizr ()
{

echo -e "${sep}"
echo -e "${sep}     Welcome to the Organizr installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${sep} Let's get started with some packages${nc}"
echo -e "${sep}"
echo " "

pkg update && pkg upgrade
pkg install -y apache24 php56 mod_php56 php56-extensions php56-pdo php56-pdo_sqlite php56-simplexml php56-zip php56-openssl git

echo " "
echo -e "${sep}"
echo -e "${sep} Modify apache${nc}"
echo -e "${sep}"
echo " "

sysrc apache_enable=YES
service apache24 start

echo " "
echo -e "${sep}"
echo -e "${sep} Grab Organizer from github${nc}"
echo -e "${sep}"
echo " "

cd  /usr/local/www/
git clone https://github.com/causefx/Organizr.git

echo " "
echo -e "${sep}"
echo -e "${msg} Open your browser and go to: ${url}http://${jailip}/${nc}"
echo -e "${sep}"
echo " "

}

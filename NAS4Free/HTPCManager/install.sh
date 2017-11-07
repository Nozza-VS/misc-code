#------------------------------------------------------------------------------#
### HTPC MANAGER INSTALL

install.htpcmanager ()
{

echo -e "${sep}"
echo -e "${sep}     Welcome to the HTPC installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${sep} Let's get started with some packages${nc}"
echo -e "${sep}"
echo " "

pkg update && pkg upgrade
pkg install -y python27 sqlite3 git

echo " "
echo -e "${sep}"
echo -e "${sep} Grab HTPC manager from github${nc}"
echo -e "${sep}"
echo " "

cd /usr/local/
git clone https://github.com/styxit/HTPC-Manager.git

echo " "
echo -e "${sep}"
echo -e "${msg} Open your browser and go to: ${url}http://${jailip}:9090${nc}"
echo -e "${sep}"
echo " "

}

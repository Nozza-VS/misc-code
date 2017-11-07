#------------------------------------------------------------------------------#
### WATCHER INSTALL

install.watcher ()
{

echo -e "${sep}"
echo -e "${sep}     Welcome to the Watcher installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${sep} Let's get started with some packages${nc}"
echo -e "${sep}"
echo " "

pkg update && pkg upgrade
pkg install git python3 sqlite3

cd /usr/local/
git clone https://github.com/nosmokingbandit/Watcher3.git

echo " "
echo -e "${sep}"
echo -e "${sep} Start watcher${nc}"
echo -e "${sep}"
echo " "

python watcher/watcher.py --daemon --log /var/log/ --db /var/db/watcher.sqlite --pid /var/run/watcher.pid

echo " "
echo -e "${sep}"
echo -e "${msg} Open your browser and go to: ${url}http://${jailip}:9090${nc}"
echo -e "${sep}"
echo " "

}
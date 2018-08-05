#------------------------------------------------------------------------------#
### RADARR INSTALL

install.radarr ()
{

echo -e "${sep}"
echo -e "${sep}     Welcome to the Radarr installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${sep} Let's get started with some packages${nc}"
echo -e "${sep}"
echo " "

pkg update && pkg upgrade
pkg install -y mono mediainfo sqlite3 libgdiplus

cd /usr/local/
fetch https://github.com/Radarr/Radarr/releases/download/latest/Radarr.develop.latest.linux.tar.gz
tar -zxvf Radarr.develop.*.linux.tar.gz
rm Radarr.*.linux.tar.gz
echo "/usr/local/bin/mono /usr/local/Radarr/Radarr.exe" > /etc/rc.d/radarr
chmod 555 /etc/rc.d/radarr
#this is needed for updates within Radarr
ln -s /usr/local/bin/mono /bin

echo " "
echo -e "${sep}"
echo -e "${sep} Start watcher${nc}"
echo -e "${sep}"
echo " "

service radarr start

echo " "
echo -e "${sep}"
echo -e "${msg} Open your browser and go to: ${url}http://${jailip}:7878${nc}"
echo -e "${sep}"
echo " "

}
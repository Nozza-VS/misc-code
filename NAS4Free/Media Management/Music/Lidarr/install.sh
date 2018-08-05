#------------------------------------------------------------------------------#
### LIDARR CONFIRM INSTALL

confirm.install.lidarr ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Lidarr? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.lidarr
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}



#------------------------------------------------------------------------------#
### LIDARR INSTALL

install.lidarr ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Lidarr Installer${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's install required packages${nc}"
echo -e "${msg}   and create a user first${nc}"
echo -e "${sep}"
echo " "

pw useradd lidarr -d /nonexistent
pkg install wget nano mono sqlite3 git-lite

echo " "
echo -e "${sep}"
echo -e "${msg} Download Lidarr${nc}"
echo -e "${msg} Lidarr will be installed to:${nc}"
echo -e "${inf}    /usr/local/share/lidarr${nc}"
echo -e "${sep}"
echo " "

# Download to /tmp
#TODO: Add version choice later
wget -O /tmp/Lidarr.develop.0.2.0.289.linux.tar.gz https://ci.appveyor.com/api/buildjobs/w3mqu9a4gtrdgv38/artifacts/Lidarr.develop.0.2.0.289.linux.tar.gz
# Extract 
tar -xvf Lidarr.develop.0.2.0.289.linux.tar.gz -C /usr/local/share/lidarr
# Remove archive after extraction
#TODO: Add choice to delete or not
rm Lidarr.develop.*.linux.tar.gz

echo " "
echo -e "${sep}"
echo -e "${msg} Copy startup script & make executable${nc}"
echo -e "${sep}"
echo " "

#TODO: Upload my rc.d script to github and add download to it here
wget -O /usr/local/etc/rc.d/lidarr https://mygithublink
# Ensure corrent permissions
chmod +x /usr/local/etc/rc.d/lidarr

echo " "
echo -e "${sep}"
echo -e "${msg} Enable Lidarr at startup${nc}"
echo -e "${sep}"
echo " "

echo 'lidarr_enable="YES"' >> /etc/rc.conf

echo " "
echo -e "${sep}"
echo -e "${msg} Start Lidarr${nc}"
echo -e "${sep}"
echo " "

service lidarr start

echo " "
echo -e "${sep}"
echo -e "${msg} Open your browser and go to: ${url}yourjailip:8686${nc}"
echo -e "${msg} to finish setting up your CouchPotato server${nc}"
echo -e "${sep}"
echo " "

echo " "
echo -e "${sep}"
echo -e "${msg} Done here!${nc}"
echo -e "${msg} Feel free to visit the project homepage at:${nc}"
echo -e "${url}    https://github.com/lidarr/Lidarr${nc}"
echo -e "${url}    http://lidarr.audio${nc}"
echo -e "${sep}"
echo " "

}

confirm.install.lidarr
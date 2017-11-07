#------------------------------------------------------------------------------#
### DELUGE CONFIRM INSTALL

confirm.install.deluge ()
{
# Confirm with the user
echo -e "${emp} WARNING: THIS HAS BEEN UNTESTED"
echo -e "${emp} USE AT YOUR OWN RISK"
read -r -p "   Confirm Installation of Deluge? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.deluge
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}



#------------------------------------------------------------------------------#
### DELUGE INSTALL

install.deluge ()
{
confirm ()
{
# Confirm with the user
read -r -p "   Continue? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              echo -e " "
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo -e " "
              echo " "
              exit
              ;;
esac
}
echo -e "${sep}"
echo -e "     \033[1;37mWelcome to the Deluge setup!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo -e "${emp}   This should be run in host NAS system${nc}"
echo -e "${emp}   If you are inside a jail please answer no${nc}"
echo -e "${emp}   Exit your jail and start again${nc}"
echo " "
continue
echo " "
echo -e "${sep}"
echo -e "${msg} Let's get started with adding a user${nc}"
echo -e "${sep}"
echo " "

pw useradd -n deluge -u 335 -c "Deluge BitTorrent Client" -s /sbin/nologin -w no

echo " "
echo -e "${sep}"
echo -e "${msg} Now to enter the jail and set up some basic stuff${nc}"
echo -e "${sep}"
echo " "

jexec ${jail} csh
#pw useradd -n deluge -u 335 -c "Deluge BitTorrent Client" -s /sbin/nologin -w no
pw useradd -n deluge -u ${user_ID} -c "Deluge BitTorrent Client" -s /sbin/nologin -w no
mkdir -p /home/deluge/.config/deluge
chown -R deluge:deluge /home/deluge/

# Also create folder for plugins
mkdir /.python-eggs
chmod 777 /.python-eggs

echo " "
echo -e "${sep}"
echo -e "${msg} Time to install the packages${nc}"
echo -e "${sep}"
echo " "

pkg install -y deluge nano

# Create file
touch /usr/local/etc/rc.d/deluged

# Tell user to modify certain things before moving on
echo " Change the deluge user in the scripts from the default asjklasdfjklasdf"
echo " to the 'deluge' user created earlier"

# Set permissions
chmod 555 /usr/local/etc/rc.d/deluged

# Set daemon to launch upon jail start and specify user
echo 'deluged_enable="YES"' >> /etc/rc.conf
echo 'deluged_user="deluge"' >> /etc/rc.conf

echo 'deluge_web_enable="YES"' >> /etc/rc.conf
echo 'deluge_web_user="deluge"' >> /etc/rc.conf


# User to allow remote access to daemon
echo "${deluge_user}:${deluge_user_password}:10" >> /home/deluge/.config/deluge/auth
# Let user know how to add more users to connect to the daemon
#echo "${deluge_user}:${deluge_user_password}:10" >> /home/deluge/.config/deluge/auth
echo " "

#start deluge to generate config files
service deluged start
service deluged stop

# Allow remote connections
echo " Find and change 'allow_remote' from false to true."
echo " Once you are done press Ctrl+X then Y to close and save the file"
echo -e "${emp}   Make sure you read above before continuing${nc}"
continue
nano /home/deluge/.config/deluge/core.conf

# Disable IPV6
echo "Edit /etc/protocols and disable ipv6 by placing '#' in front of ipv6"
echo -e "${emp}   Make sure you read above before continuing${nc}"
continue
nano /etc/protocols

# Modify deluge web default server
nano /home/deluge/.config/deluge/web.conf
# Change this line: "default_daemon": "", 

# Start the daemon
/usr/local/etc/rc.d/deluged start
/usr/local/etc/rc.d/deluge_web start
# May have to use this instead:
# /usr/local/etc/rc.d/deluge_web start

echo " Now you should be able to head to http://jailsipaddress:8112 and login"
echo " using the password 'deluge' without the quotes"

echo " "
echo -e "${sep}"
echo " That should be it!"
echo " Happy torrenting!!"
echo -e "${sep}"
echo " "

}

confirm.install.deluge
#------------------------------------------------------------------------------#
### TEAMSPEAK 3 SERVER CONFIRM INSTALL

confirm.install.teamspeak3 ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Teamspeak 3? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.teamspeak3
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### TEAMSPEAK 3 SERVER INSTALL

install.teamspeak3 ()
{

#Update the pkg management system first
pkg update
pkg upgrade

cd /usr/ports/audio/teamspeak3-server
make install clean; rehash

# Tell user to accept defaults
# Tell user to press A when license shows

# fetch scripts from github
# teamspeak3-server init script
# ts3server.sh

echo 'teamspeak_enable="YES"' >> /etc/rc.conf

# Start server
service teamspeak start

# Instruct user to check log files for admin token
cat /var/log/teamspeak/ts3server_*_1.log

# mention port forwarding
# Forward the following ports to your jails IP
# TCP: 10011,30033
# UDP: 9987

}

confirm.install.teamspeak3

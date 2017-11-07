#------------------------------------------------------------------------------#
### TEAMSPEAK 3 SERVER BOT CONFIRM INSTALL

confirm.install.teamspeak3bot ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Teamspeak 3 Server Bot? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.teamspeak3bot
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### TEAMSPEAK 3 SERVER BOT HOSTING EDITION INSTALL (MUCH HARDER TO SET UP)

install.teamspeak3bot ()
{

# Update the pkg management system first
pkg update
pkg upgrade

# Install packages
pkg install -y screen openjdk8 wget

# download server bot
wget -r -l1 -np -A "JTS3ServerMod_*.zip" http://www.stefan1200.de/downloads/

# fetch start script from github
# ts3serverbot.sh

# make it executable

# run it

# Instruct user how to make it run at jail startup

}

confirm.install.teamspeak3bot

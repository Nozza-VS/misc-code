#!/bin/sh
#	Install script for Deluge in a jailed environment
#   See http://forums.nas4free.org/viewtopic.php?f=79&t=5418 or
#   http://forums.nas4free.org/viewtopic.php?f=79&t=7157 for more info.
#   Copyrighted 2016 by Ashley Townsend under the Beerware License.

# TODO: Clean up script
# TODO: Test script in a jail

##### START CONFIGURATION #####

# Create a jail within nas gui and note the ID it is given, add that ID here.
# You can also use the name of the jail instead as the ID may change.
jail="Deluge"
user_ID="UID""
deluge_user="JonDoe"
deluge_user_password="MyC0mpL3xPass"

##### END CONFIGURATION #####

confirm ()
{
# Confirm with the user
read -r -p "   Continue? [Y/n] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              echo " "
              echo -e " \033[1;32mGreat! Let's continue..\033[0m"
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo -e " \033[1;31mBugger :( Stopping script..\033[0m"
              echo -e " \033[1;31mTry the NAS4Free forums if you need help.\033[0m"
              echo " "
              exit
              ;;
esac
}

# define our bail out shortcut function anytime there is an error - display
# the error message, then exit returning 1.
exerr () { echo -e "$*" >&2 ; exit 1; }



echo -e "\033[1;30m##################################################\033[0m"
echo -e "     \033[1;37mWelcome to the Deluge setup!\033[0m"
echo -e "\033[1;30m################################################## \033[0m"
echo " "
echo " "
echo -e "   \033[1;31mThis should be run in host NAS system\033[0m";
echo -e "   \033[1;31mIf you are inside a jail please answer no\033[0m";
echo -e "   \033[1;31mExit your jail and start again\033[0m";
echo " "
continue
echo " "
echo -e "\033[1;30m##################################################\033[0m"
echo -e " \033[1;37mLet's get started with adding a user\033[0m"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

pw useradd -n deluge -c "Deluge BitTorrent Client" -s /sbin/nologin -w no

echo " "
echo -e "\033[1;30m##################################################\033[0m"
echo -e " \033[1;37mNow to enter the jail and set up some basic stuff\033[0m"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

jexec $jail csh
pw useradd -n deluge -u $user_ID -c "Deluge BitTorrent Client" -s /sbin/nologin -w no
mkdir -p /home/deluge/.config/deluge
chown -R deluge:deluge /home/deluge/

# Also create folder for plugins
mkdir /.python-eggs
chmod 777 /.python-eggs

echo " "
echo -e "\033[1;30m##################################################\033[0m"
echo -e " \033[1;37mTime to install the packages\033[0m"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

pkg install -y deluge nano

# Create file
touch /usr/local/etc/rc.d/deluged

# Tell user to modify certain things before moving on
echo " Change the deluge user in the scripts from the default asjklasdfjklasdf
echo " to the 'deluge' user created earlier"

# Set permissions
chmod 555 /usr/local/etc/rc.d/deluged

# Set daemon to launch upon jail start
echo 'deluged_enable="YES"' >> /etc/rc.conf
echo 'deluge_web_enabled="YES"' >> /etc/rc.conf
echo 'deluged_user="deluge"' >> /etc/rc.conf

# User to allow remote access to daemon
echo "$deluge_user:$deluge_user_password:10" >> /home/deluge/.config/deluge/auth
# Let user know how to add more users to connect to the daemon
echo " $deluge_user:$deluge_user_password:10 >> /home/deluge/.config/deluge/auth"
echo " "

# Allow remote connections
echo " Find and change “allow_remote” from false to true."
echo " Once you are done press Ctrl+X then Y to close and save the file"
echo -e "   \033[1;31mMake sure you read above before continuing\033[0m";
continue
nano /home/deluge/.config/deluge/core.conf

# Disable IPV6
echo "Edit /etc/protocols and disable ipv6 by placing '#' in front of ipv6"
echo -e "   \033[1;31mMake sure you read above before continuing\033[0m";
continue
nano /etc/protocols

# Start the daemon
/usr/local/etc/rc.d/deluged start
# May have to use this instead:
# /usr/local/etc/rc.d/deluge_web start

echo " Now you should be able to head to http://jailsipaddress:8112 and login"
echo " using the password 'deluge' without the quotes"

echo " "
echo -e "\033[1;30m##################################################\033[0m"
echo " That should be it!"
echo " Happy torrenting!!"
echo -e "\033[1;30m################################################## \033[0m"
echo " "

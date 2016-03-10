#!/bin/sh
# Script Version: TESTING-1.0 (March 10, 2016)
#	Install script for Munin in a jailed environment
#   See http://forums.nas4free.org/viewtopic.php?f=79&t=6272 for more info.
#   Copyrighted 2016 by Ashley Townsend under the Beerware License.

##### START CONFIGURATION #####

# Create a jail within nas gui and note the ID it is given, add that ID here.
# You can also use the name of the jail instead as the ID may change.
jail="Munin"

##### END CONFIGURATION #####

# Add some colour!
nc='\033[0m'        # No Color
alt='\033[0;31m'    # Alert Text
emp='\033[1;31m'    # Emphasis Text
msg='\033[1;37m'    # Message Text
url='\033[1;32m'    # URL
qry='\033[0;36m'    # Query Text
sep='\033[1;30m-------------------------------------------------------\033[0m'    # Line Seperator
cmd='\033[1;35m'    # Command to be entered

confirm ()
{
echo -e "   \033[1;31m User input required\033[0m";
# Confirm with the user
read -r -p "   [Yes/No] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              echo " "
              echo -e " \033[1;32mOk! Let's continue..\033[0m"
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo -e " \033[1;31mStopping script..\033[0m"
              echo " "
              exit
              ;;
esac
}


# define our bail out shortcut function anytime there is an error - display
# the error message, then exit returning 1.
exerr () { echo -e "$*" >&2 ; exit 1; }



echo -e "${sep}"
echo -e "     \033[1;37mWelcome to the Munin setup!\033[0m"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "     \033[1;37mLet's get started with some packages\033[0m"
echo -e "${sep}"
echo " "

# Install packages
pkg install -y munin-node nano

echo " "
echo -e "${sep}"
echo " Packages done - Now to allow Munin-Master to access Munin-Node"
echo -e "${sep}"
echo " "

echo " Scroll down to the line which says:"
echo "      allow ^127\.0\.0\.1$"
echo "      allow ^::1$"
echo " Add: allow ^192\.168\.1\.251$"
echo " "
confirm
nano /usr/local/etc/munin/munin-node.conf

echo " "
echo -e "${sep}"
echo " Time to configure Munin-Node"
echo -e "${sep}"
echo " "

/usr/local/sbin/munin-node-configure --shell | sh -x
/usr/local/etc/rc.d/munin-node onestart
echo 'munin_node_enable="YES"' >> /etc/rc.conf

echo " "
echo -e "${sep}"
echo " That's it for the Node setup, now for the Master"
echo -e "${sep}"
echo " "

echo " Entering jail now.."
jexec $jail csh

echo " Check hosts file to ensure it matches"
cat /etc/hosts
echo " It should show as:"
echo "      ::1 localhost localhost.local"
echo "      127.0.0.1 localhost localhost.local"
echo "      192.168.1.250 nas4free nasfree.local"
echo "      192.168.1.251 munin munin.local"
echo " If it does not look like this run these commands:"
echo "      echo '192.168.1.250 nasfree nas4free.local' >> /etc/hosts"
echo "      echo '192.168.1.251 munin munin.local' >> /etc/hosts"

echo " "
echo -e "${sep}"
echo " Ok, now to install Munin-Master & other required packages"
echo -e "${sep}"
echo " "

pkg install -y munin-master nano apache24
echo 'apache22_enable="YES"' >> /etc/rc.conf

echo " "
echo -e "${sep}"
echo " Now to edit Munin-Master configuration to tell it about Munin-Node we set up"
echo -e "${sep}"
echo " "

echo " Scroll down to the line which says:"
echo "# a simple host tree
echo "[munin.local]"
echo "    address 127.0.0.1"
echo "    use_node_name yes"
echo " "
echo " Add the following bellow:"
echo " "
echo " [nasfree.local]"
echo "    address 192.168.1.250"
echo "    use_node_name yes"
nano /usr/local/etc/munin/munin.conf

echo -e "${sep}"
echo -e "     \033[1;37mNow to alert Apache about Munin\033[0m"
echo -e "${sep}"
echo " "

touch /usr/local/etc/apache22/Includes/munin.conf

echo " Copy the following in to this file before exiting & saving"
echo "Alias /munin "/usr/local/www/munin"
echo " "
echo "<Directory /usr/local/www/munin>"
echo "Options none"
echo "AllowOverride Limit"
echo "Order Deny,Allow"
echo "Deny from all"
echo "Allow from all"
echo "</Directory>"
echo " "
nano /usr/local/etc/apache22/Includes/munin.conf

# Deleting .htaccess
rm -rf /usr/local/www/munin/.htaccess

echo " "
echo -e "${sep}"
echo -e "     \033[1;37mPerforming sanity check\033[0m"
echo -e "${sep}"
echo " "

/usr/local/etc/rc.d/apache22 configtest
echo " If sanity check responds with 'Syntax OK', continue."
confirm

echo " "
echo -e "${sep}"
echo -e "     \033[1;37mStarting Apache..\033[0m"
echo -e "${sep}"
echo " "

/usr/local/etc/rc.d/apache24 start

echo " "
echo -e "${sep}"
echo " Now in your web browser, head to: http://192.168.1.251/munin"
echo " The Munin overview page should show up"
echo " Click on the N4F host and a list of graphs will be displayed on a
echo " daily/weekly/monthly/yearly basis:"
echo " And that's it - Munin will now be graphing everything for your N4F host!"
echo -e "${sep}"
echo " "

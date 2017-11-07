#------------------------------------------------------------------------------#
### CALIBRE CONFIRM INSTALL

confirm.install.calibre ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Calibre? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.calibre
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### CALIBRE INSTALL

install.calibre ()
{

echo -e "${sep}"
echo -e "${sep}     Welcome to the Calibre installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${sep} Let's get started with some packages${nc}"
echo -e "${sep}"
echo " "

pkg install -y nano calibre

# Configure /etc/rc.conf
echo 'calibre_enable="YES"' >> /etc/rc.conf
echo 'calibre_user="root"' >> /etc/rc.conf
echo 'calibre_library="${CALIBRELIBRARYPATH}"' >> /etc/rc.conf

#echo " Modify this file to use root as the user"
#echo "    : ${calibre_user:=root}" #TODO: Use sed for this

nano /usr/local/etc/rc.d/calibre

echo " Start Calibre"
echo " If you want to start it manually without restarting your jail"
calibre-server --with-library="${CALIBRELIBRARYPATH}"

echo " "
echo -e "${sep}"
echo " That should be it!"
echo " Happy reading!!"
echo -e "${sep}"
echo " "

}

confirm.install.calibre
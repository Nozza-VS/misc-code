#==============================================================================#
### MADSONIC CONFIRM INSTALL

confirm.install.madsonic ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Madsonic? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.madsonic
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### MADSONIC INSTALL

install.madsonic ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Welcome to the Madsonic installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's get started with some packages${nc}"
echo -e "${sep}"
echo " "

#pkg install -y madsonic-jetty
pkg install -y madsonic-standalone

echo " "
echo -e "${sep}"
echo " Adding madsonic to rc.conf"
echo -e "${sep}"
echo " "

echo 'madsonic_enable="YES"' >> /etc/rc.conf

echo " "
echo -e "${sep}"
echo -e "${msg} Now let's make sure madsonic starts.${nc}"
echo -e "${msg} You can manually do this with:${nc}"
echo -e "${cmd}    /usr/local/etc/madsonic start${nc}"
echo -e "${msg} For now, this script will do it automatically.${nc}"
echo -e "${sep}"
echo " "

/usr/local/etc/rc.d/madsonic start

echo " "
echo -e "${sep}"
echo -e "${msg} If madsonic started as it should you can connect to it via your${nc}"
echo -e "${msg} browser with following adress: Jail-IP:4040${nc}"
echo -e "${msg} Default username is admin, and password admin.${nc}"
echo -e "${sep}"
echo " "

echo " "
echo -e "${sep}"
echo " That should be it!"
echo " Enjoy your Subsonic server!"
echo -e "${sep}"
echo " "
}

confirm.install.madsonic

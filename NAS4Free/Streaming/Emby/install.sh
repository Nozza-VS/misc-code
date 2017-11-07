#------------------------------------------------------------------------------#
### EMBY SERVER CONFIRM INSTALL

confirm.install.emby ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Emby Media Server? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.emby
               ;;
    *)
              # Otherwise exit...
              echo " "
			  echo -e "${alt}   Install cancelled${nc}"
			  echo " "
              return
              ;;
esac
}



#------------------------------------------------------------------------------#
### EMBY SERVER INSTALL

install.emby ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Emby Install Script${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's start with installing Emby from packages${nc}"
echo -e "${sep}"
echo " "

pkg install -y emby-server

echo " "
echo -e "${sep}"
echo -e "${msg}   Enable automatic startup of Emby Server${nc}"
echo -e "${sep}"
echo " "

sysrc emby_server_enable="YES"

echo " "
echo -e "${sep}"
echo -e "${msg}   Start the Emby Server${nc}"
echo -e "${sep}"
echo " "

service emby-server start

echo " "
echo -e "${sep}"
echo -e "${msg} Using a web browser, head to ${url}yourjailip:8096${nc}"
echo -e "${msg} to finish setting up your Emby server${nc}"
echo -e " "
echo -e "${msg} You should also recompile ffmpeg+imagemagick${nc}"
echo -e "${msg} This option can be found in the Emby submenu of this script${nc}"
echo -e "${msg} It's also advised to run the update option after a clean install.${nc}"
echo -e "${sep}"
echo " "

}

confirm.install.emby

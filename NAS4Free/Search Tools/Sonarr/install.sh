#------------------------------------------------------------------------------#
### SONARR CONFIRM INSTALL

confirm.install.sonarr ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Sonarr? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.sonarr
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}



#------------------------------------------------------------------------------#
### SONARR INSTALL

install.sonarr ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Sonarr Install Script${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's start with installing Sonarr from packages${nc}"
echo -e "${sep}"
echo " "

pkg install -y sonarr mediainfo

echo " "
echo -e "${sep}"
echo -e "${msg}   Start Sonarr${nc}"
echo -e "${sep}"
echo " "

service sonarr start

echo " "
echo -e "${sep}"
echo -e "${msg} Open your browser and go to: ${url}yourjailip:8989${nc}"
echo -e "${msg} to finish setting up Sonarr${nc}"
echo -e "${sep}"
echo " "

}

confirm.install.sonarr
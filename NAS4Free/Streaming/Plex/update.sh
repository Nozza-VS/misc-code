#------------------------------------------------------------------------------#
### PLEX UPDATE

update.plex ()
{

echo " "
echo -e "${sep}"
echo "   Plex Media Server Updater"
echo -e "${sep}"
echo " "

echo " "
echo -e "${sep}"
echo "   Let's start with downloading the update script and running it"
echo -e "${sep}"
echo " "

cd $(myappsdir)
fetch https://raw.githubusercontent.com/JRGTH/nas4free-plex-extension/master/plex/plexinit && chmod +x plexinit && ./plexinit

}

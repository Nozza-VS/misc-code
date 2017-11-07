#------------------------------------------------------------------------------#
### SABNZBD CONFIRM UPDATE

confirm.update.sabnzbd ()
{
# Confirm with the user
read -r -p "   Confirm Update of Sabnzbd? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.sabnzbd
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### SABNZBD UPDATE

update.sabnzbd ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Welcome to the SABnzbd updater!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's start with updating packages if needed${nc}"
echo -e "${sep}"
echo " "

pkg update
pkg upgrade

echo " "
echo -e "${sep}"
echo -e "${msg} Now let's grab the update of SABnzbd${nc}"
echo -e "${msg} Currently set to grab:${inf} ${sab_ver} ${nc}"
echo -e "${msg} You can modify the 'sab_ver' variable near the top of the script${nc}"
echo -e "${msg} to change the version that is downloaded.${nc}"
echo -e "${sep}"
echo " "

cd tmp
fetch "http://downloads.sourceforge.net/project/sabnzbdplus/sabnzbdplus/${sab_ver}/SABnzbd-${sab_ver}-src.tar.gz"
tar xfz SABnzbd-${sab_ver}-src.tar.gz -C /usr/local
rm SABnzbd-${sab_ver}-src.tar.gz
mv /usr/local/SABnzbd-${sab_ver} /usr/local/Sabnzbd

echo " "
echo -e "${sep}"
echo -e "${msg} Before we are able to run SABnzbd, we need to modify a file${nc}"
echo -e "${msg} Using nano, change the first line (/usr/bin/python)${nc}"
echo -e "${msg} to match the following:${nc}"
echo -e "${cmd}    #!/usr/local/bin/python2.7${nc}"
echo -e "${sep}"
echo " "

nano /usr/local/Sabnzbd/SABnzbd.py

echo " "
echo -e "${sep}"
echo -e "${msg} Start it up${nc}"
echo -e "${sep}"
echo " "

/usr/local/etc/rc.d/sabnzbd start

echo " "
echo -e "${sep}"
echo -e "${msg} Done! Head to: ${url}yourjailip:8080${nc}"
echo -e "${msg} to visit your SABnzbd!${nc}"
echo -e "${sep}"
echo " "
}

confirm.update.sabnzbd
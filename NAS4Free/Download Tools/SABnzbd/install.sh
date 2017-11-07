#------------------------------------------------------------------------------#
### SABNZBD CONFIRM INSTALL

confirm.install.sabnzbd ()
{
# Confirm with the user
read -r -p "   Confirm Installation of SABnzbd? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.sabnzbd
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### SABNZBD INSTALL

install.sabnzbd ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Welcome to the SABnzbd installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's get right to it and download the required packages${nc}"
echo -e "${sep}"
echo " "

pkg install -y python27 py27-sqlite3
pkg install -y py27-pip py27-yenc py27-cheetah py27-openssl py27-feedparser py27-utils par2cmdline-tbb
pkg install -y unrar unzip par2cmdline nano

pip install cryptography --upgrade
pip install --upgrade sabyenc

echo " "
echo -e "${sep}"
echo -e "${msg} Now let's grab SABnzbd itself${nc}"
echo -e "${sep}"
echo " "

cd tmp
#fetch --no-verify-peer -o /tmp/SABnzbd-${sab_ver}-src.tar.gz https://github.com/sabnzbd/sabnzbd/releases/download/${sab_ver}/SABnzbd-${sab_ver}-src.tar.gz
fetch "http://downloads.sourceforge.net/project/sabnzbdplus/sabnzbdplus/${sab_ver}/SABnzbd-${sab_ver}-src.tar.gz"
tar xfz SABnzbd-${sab_ver}-src.tar.gz -C /usr/local
rm SABnzbd-${sab_ver}-src.tar.gz
mv /usr/local/SABnzbd-${sab_ver} /usr/local/Sabnzbd

#ln -s /usr/local/bin/python /usr/bin/python

echo " "
echo -e "${sep}"
echo -e "${msg} Fetch startup script${nc}"
echo -e "${sep}"
echo " "

fetch --no-verify-peer -o /usr/local/etc/rc.d/sabnzbd "https://raw.githubusercontent.com/Nostalgist92/misc-code/master/NAS4Free/SABnzbd/init-script"
chmod 755 /usr/local/etc/rc.d/sabnzbd
chmod +x /usr/local/etc/rc.d/sabnzbd
echo 'sabnzbd_enable="YES"' >> /etc/rc.conf

echo " "
echo -e "${sep}"
echo -e "${msg} Before we are able to run SABnzbd, we need to modify a file${nc}"
echo -e "${msg} Using nano, change the first line '/usr/bin/python'${nc}"
echo -e "${msg} to match the following:${nc}"
echo -e "${cmd}    #!/usr/local/bin/python2.7${nc}"
echo -e "${sep}"
echo " "

nano /usr/local/Sabnzbd/SABnzbd.py
# On the first line, change #!/usr/bin/python to #!/usr/local/bin/python

echo " "
echo -e "${sep}"
echo -e "${msg} Start it up${nc}"
echo -e "${sep}"
echo " "

/usr/local/etc/rc.d/sabnzbd start

echo " "
echo -e "${sep}"
echo -e "${msg} Done! Head to: ${url}yourjailip:8080${nc}"
echo -e "${msg} to finish the setup!${nc}"
echo -e "${sep}"
echo " "

}

confirm.install.sabnzbd
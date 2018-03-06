#------------------------------------------------------------------------------#
### EMBY SERVER CONFIRM INSTALL

confirm.install.asterisk ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Asterisk? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.asterisk
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
echo -e "${msg}   Asterisk Install Script${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's start with installing Asterisk from packages${nc}"
echo -e "${sep}"
echo " "

pkg install -y asterisk

# Ensure correct permissions
chown -R asterisk:asterisk /usr/local/etc/asterisk/ /usr/local/lib/asterisk /usr/local/share/asterisk /var/db/asterisk
chmod 644 /usr/local/etc/asterisk/*

echo " "
echo -e "${sep}"
echo -e "${msg}   Enable automatic startup of Asterisk${nc}"
echo -e "${sep}"
echo " "

sysrc asterisk_enable="YES"

echo " "
echo -e "${sep}"
echo -e "${msg}   Start Asterisk${nc}"
echo -e "${sep}"
echo " "

service asterisk start

echo " "
echo -e "${sep}"
echo -e "${msg} These 3 files arethe main config files:${nc}"
echo -e "${msg}   sip.conf${nc}"
echo -e "${msg}   extensions.conf${nc}"
echo -e "${msg}   voicemail.conf${nc}"
echo -e "${sep}"
echo " "

}

confirm.install.asterisk

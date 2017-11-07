#------------------------------------------------------------------------------#
### OMBI SERVER CONFIRM INSTALL

confirm.install.ombi ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Ombi Media Requests? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.ombi
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}



#------------------------------------------------------------------------------#
### OMBI INSTALL

install.ombi ()
{

ombi.continue ()
{
echo -e "${msep}"
echo -e "${emp}   Press Enter To Continue${nc}"
echo -e "${msep}"
read -r -p " " response
case "$response" in
    *)
              echo " "
              ;;
esac
}

echo " "
echo -e "${sep}"
echo -e "${msg}   Ombi Install Script${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's start with some required packages${nc}"
echo -e "${sep}"
echo " "

#Install packages
pkg install wget mono screen unzip nano git sqlite3

# Set default editor
setenv EDITOR /usr/local/bin/nano

echo " "
echo -e "${sep}"
echo -e "${msg}   Download Ombi${nc}"
echo -e "${sep}"
echo " "

# Download Ombi
wget -O /tmp/Ombi.zip https://github.com/tidusjar/Ombi/releases/download/v2.2.1/Ombi.zip

echo " "
echo -e "${sep}"
echo -e "${msg}   Extract Ombi${nc}"
echo -e "${sep}"
echo " "

# Unzip Ombi
unzip /tmp/Ombi.zip -d /usr/local/share/
# Move Ombi
mv /usr/local/share/Release /usr/local/share/ombi/

echo " "
echo -e "${sep}"
echo -e "${msg}   Create startup file${nc}"
echo -e "${sep}"
echo " "

# Create ombi file
touch /usr/local/bin/ombi
echo "#!/bin/sh" > /usr/local/bin/ombi
echo "cd /usr/local/share/ombi/" > /usr/local/bin/ombi
echo "/usr/local/bin/screen -d -m -S ombi /usr/local/bin/mono /usr/local/share/ombi/Ombi.exe" > /usr/local/bin/ombi
chmod 775 /usr/local/bin/ombi

echo " "
echo -e "${sep}"
echo -e "${msg}   Add these lines to crontab${nc}"
echo -e "${msg}   Copy the lines before pressing Enter then paste in to crontab${nc}"
echo -e "${msg}   Close crontab afterwards with the following combination of keys${nc}"
echo -e "${msg}   Ctrl+X then Y then Enter${nc}"
echo -e "${sep}"
echo " "

# Add to crontab
echo "SHELL=/bin/sh"
echo "PATH=/etc:/bin:/sbin:/usr/bin:/usr/sbin"
echo "#start ombi"
echo "@reboot /usr/local/bin/ombi"
echo " "

ombi.continue

crontab -e

echo " "
echo -e "${sep}"
echo -e "${msg}   Restart jail and visit http://jailip:3579${nc}"
echo -e "${sep}"
echo " "

}

confirm.install.ombi

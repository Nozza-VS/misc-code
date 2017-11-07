#------------------------------------------------------------------------------#
### NZBGET CONFIRM INSTALL

confirm.install.nzbget ()
{
# Confirm with the user
read -r -p "   Confirm Installation of NZBGet? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.nzbget
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}



#------------------------------------------------------------------------------#
### NZBGET INSTALL

install.nzbget ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Welcome to the NZBGet installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's get right to it and download the package${nc}"
echo -e "${msg}    Will grab ffmpeg as well purely for ffprobe${nc}"
echo -e "${sep}"
echo " "

pkg install -y nzbget ffmpeg

echo " "
echo -e "${sep}"
echo -e "${msg} Copy the default configuration to get the webui working${nc}"
echo -e "${sep}"
echo " "

cp /usr/local/etc/nzbget.conf.sample /usr/local/etc/nzbget.conf

echo " "
echo -e "${sep}"
echo -e "${msg} Enable NZBGet at startup${nc}"
echo -e "${sep}"
echo " "

sysrc 'nzbget_enable=YES'

echo " "
echo -e "${sep}"
echo -e "${msg} Create a temp folder for NZBGet and modify config file${nc}"
echo -e "${msg} to enable the web interface${nc}"
echo -e "${sep}"
echo " "

mkdir -p /downloads/dst
# Need to modify "WebDir=" at line 79 of "/usr/local/etc/nzbget.conf"
# Needs to be "WebDir=/usr/local/share/nzbget/webui"
# Maybe use "sed" command for this which could also eliminate the cp command above

echo " "
echo -e "${sep}"
echo -e "${msg} Start NZBGet${nc}"
echo -e "${sep}"
echo " "

service nzbget start

echo " "
echo -e "${sep}"
echo -e "${msg} Now finish setting it up by opening your web browser and heading to:${nc}"
echo -e "${url}    http://your-jail-ip:6789${nc}"
echo -e "${msg} Default username: nzbget${nc}"
echo -e "${msg} Default password: tegbzn6789${nc}"
echo -e "${sep}"
echo " "

}

confirm.install.nzbget
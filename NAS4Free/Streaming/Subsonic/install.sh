#------------------------------------------------------------------------------#
### SUBSONIC CONFIRM INSTALL

confirm.install.subsonic ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Subsonic? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.subsonic
               ;;
    *)
              # Otherwise exit...
              echo " "
			  echo " Install cancelled"
			  echo "  "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### SUBSONIC INSTALL

install.subsonic ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Welcome to the Subsonic installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's get started with some packages${nc}"
echo -e "${sep}"
echo " "

pkg install -y subsonic-standalone
pkg install -y xtrans xproto xextproto javavmwrapper flac openjdk8 ffmpeg
pkg install -y https://github.com/Nostalgist92/misc-code/blob/master/NAS4Free/Subsonic/lame.tbz

echo " "
echo -e "${sep}"
echo -e "${msg} Create folders for Subsonic${nc}"
echo -e "${sep}"
echo " "

mkdir -p /var/subsonic/transcode
mkdir /var/subsonic/standalone
cp /usr/local/bin/lame /var/subsonic/transcode/
cp /usr/local/bin/flac /var/subsonic/transcode/
cp /usr/local/bin/ffmpeg /var/subsonic/transcode/
cd /tmp/
# Download Subsonic from sourceforge & extract
fetch http://heanet.dl.sourceforge.net/project/subsonic/subsonic/${subsonic_ver}/subsonic-${subsonic_ver}-standalone.tar.gz
tar xvzf /tmp/subsonic-${subsonic_ver}-standalone.tar.gz -C /var/subsonic/standalone
chmod 777 *.*

echo " "
echo -e "${sep}"
echo -e "${msg} Now let's make sure subsonic starts.${nc}"
echo -e "${msg} You can manually do this with:${nc}"
echo -e "${cmd}    sh /var/subsonic/standalone/subsonic.sh${nc}"
echo -e "${msg} For now, this script will do it automatically.${nc}"
echo -e "${sep}"
echo " "

sh /var/subsonic/standalone/subsonic.sh

echo " "
echo -e "${sep}"
echo -e "${msg} If subsonic started as it should you can connect to it via the browser at the${nc}"
echo -e "${msg} following adress: Jail-IP:4040, default username is admin, and password admin.${nc}"
echo -e "${sep}"
echo " "

echo " "
echo -e "${sep}"
echo " That should be it!"
echo " Enjoy your Subsonic server!"
echo -e "${sep}"
echo " "
}

confirm.install.subsonic

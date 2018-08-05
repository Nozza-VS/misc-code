#!/bin/sh

LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/MediaBrowser/Emby.Releases/releases/latest)
LATEST_VERSION=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
RELEASE_URL="https://github.com/MediaBrowser/Emby.Releases/releases/download/${LATEST_VERSION}/emby-server-freebsd_${LATEST_VERSION}_amd64.txz"

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

pkg install -y mono libass fontconfig freetype2 fribidi gnutls iconv opus samba48 sqlite3 libtheora libva libvorbis webp libx264 libzvbi

fetch --no-verify-peer -o /tmp/emby-${LATEST_VERSION}.txz ${RELEASE_URL}
pkg install -y /tmp/emby-${LATEST_VERSION}.txz 

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

#!/bin/sh
# Script Version: TESTING-1.0 (March 10, 2016)
#	Install script for Plex Media Server in a jailed environment.
#   See http://forums.nas4free.org/viewtopic.php?f=79&t=8273 or
#   https://gist.github.com/dreamcat4/f19580cbd31d8f628aca for more info.
#   Copyrighted 2016 by Ashley Townsend under the Beerware License.

#------------------------------------------------------------------------------#
### PLEX SERVER INSTALL

install.plex ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Plex Install Script${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's start with downloading the install script${nc}"
echo -e "${sep}"
echo " "

cd ${myappsdir}
fetch https://raw.githubusercontent.com/JRGTH/nas4free-plex-extension/master/plex-install.sh && chmod +x plex-install.sh && ./plex-install.sh

}

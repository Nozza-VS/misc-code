#!/bin/sh
#[ -n "$DEBUG" ] && set -x -o pipefail -e
# AIO Script	By Ashley Townsend (Nozza)    Copyright: Beerware License
version="1.1.01 (May 19, 2017)"
################################################################################

# Include
scriptPath="${0%/*}"
# Set subscripts as executable
chmod -R +x $scriptPath

# Load config
. $scriptPath/global.cfg
# Clear terminal
printf '\033\143'



################################################################################
##### MAIN MENU
################################################################################

while [ "$choice" != "q" ]
do
	echo -e "${sep}"
	echo -e "${inf} AIO Script - Version: $version by Nozza"
	echo -e "${sep}"
	echo -e "${emp} Main Menu ${msg} | ${qry} Please make a selection! ${nc}(It's best to run 1-5 INSIDE of a jail)"
	echo " "
	echo -e "${fin}   1)${url} MySQL/MariaDB + phpMyAdmin${nc}"
	echo -e "${fin}   2)${url} Host Your Own: ${msg}Web Server | Cloud Storage | Game Server | + More${nc}"
	echo -e "         (WordPress | NextCloud | Pydio | Teamspeak etc.)"
	echo -e "${fin}   3)${url} Media Streaming Servers ${nc}(Emby | Plex | Subsonic etc.)"
	echo -e "${fin}   4)${url} Sonarr ${nc}(TV & Anime) | ${url}CouchPotato ${nc}(Movies) | ${url}HeadPhones ${nc}(Music)"
	echo -e "${fin}   5)${url} Download Tools ${nc}(NZBGet - Usenet | NZBHydra (Indexer) | Deluge - Torrents)${nc}"
	echo " "
	echo -e "${cmd}   o)${msg} OneButtonInstaller${nc}"
	echo " "
	echo -e "${inf}  a) About This Script${nc}"
	echo -e "${inf}  h) Contact / Get Help${nc}"
	echo -e "${inf}  i) More Info / How-To's${nc}"
	echo " "
	echo -e "${alt}   q) Quit${nc}"
	echo " "

	echo -e "${ssep}"
    read -r -p "     Your choice: " choice
	echo -e "${ssep}"
	echo " "

        case $choice in
            '1')	printf '\033\143'; . "$scriptPath/Databases/menu.sh" ;;
            '2')	printf '\033\143'; . "$scriptPath/Self Hosting/menu.sh" ;;
            '3')	printf '\033\143'; . "$scriptPath/Streaming/menu.sh" ;;
            '4')	printf '\033\143'; . "$scriptPath/Search Tools/menu.sh" ;;
            '5')	printf '\033\143'; . "$scriptPath/Download Tools/menu.sh" ;;

			'o')	printf '\033\143'; . "$scriptPath/OBI/menu.sh" ;;

            'a')	printf '\033\143'; (. "$scriptPath/about.sh") ;;
			'i')	printf '\033\143'; . "$scriptPath/Info/menu.sh" ;;
            'h')	printf '\033\143'; (. "$scriptPath/gethelp.sh") ;;
            'u')	printf '\033\143'; (. "$scriptPath/update.sh") ;;

            'q')	echo -e "${alt}     Quitting, Bye!${nc}"
        			echo  " "
        			echo -e "${ssep}"
                	exit
                	;;

            *)   	echo -e "${alt}        Invalid choice, please try again${nc}"
        			echo " "
                	;;
        esac
done

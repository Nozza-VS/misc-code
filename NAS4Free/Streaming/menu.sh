#!/bin/sh
#------------------------------------------------------------------------------#
### STREAMING SUBMENU

streaming.submenu ()
{
while [ "$choice" != "a,h,i,m,q" ]
do
        echo -e "${sep}"
        echo -e "${fin} Media Streaming Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one: Media Streaming with...${nc}"
        echo " "
        echo -e "${fin}   1)${msg} Emby Media Server${nc}"
        echo -e "${ca}   2)${ca} Plex Media Server (Currently Unavailable)${nc}"
        echo -e "${fin}   3)${msg} Subsonic${nc}"
        echo -e "${fin}   4)${msg} Madsonic${nc}"
        echo " "
        echo -e "${fin}   5)${msg} Ombi - Plex/Emby Requests${nc}"
        echo " "
        echo -e "${ca}  a) About Media Streaming (Currently Unavailable)${nc}"
        echo -e "${ca}  i) More Info / How-To's (Currently Unavailable)${nc}"
        echo -e "${inf}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  b) Back${nc} |${emp} m) Main Menu"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1')	printf '\033\143'; echo -e "${inf} Taking you to the Emby menu..${nc}" ; echo " "
					(. $scriptPath/Streaming/Emby/menu.sh) ;;
            #'2')	printf '\033\143'; echo -e "${inf} Taking you to the Plex menu..${nc}" ; echo " "
            #    	(. $scriptPath/Streaming/Plex/menu.sh) ;;
            '3')	printf '\033\143'; (. $scriptPath/Streaming/Subsonic/menu.sh) ;;
            '4')	printf '\033\143'; (. $scriptPath/Streaming/Madsonic/menu.sh) ;;
			'5')	printf '\033\143'; (. $scriptPath/Streaming/Ombi/menu.sh) ;;

            #'a')	printf '\033\143'; about.streaming ;;
            'h')	printf '\033\143'; (. $scriptPath/help/gethelp.sh) ;;
            #'i')	printf '\033\143'; moreinfo.submenu.streaming ;;

            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;

            *)		echo -e "${alt}        Invalid choice, please try again${nc}" ; echo " " ;;

        esac
done
}

streaming.submenu

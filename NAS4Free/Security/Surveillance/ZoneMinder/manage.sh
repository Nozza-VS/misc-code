#!/bin/sh
#------------------------------------------------------------------------------#
### ZONEMINDER SUBMENU

zoneminder.submenu ()
{
while [ "$choice" != "a,h,i,b,q" ]
do
        echo -e "${sep}"
        echo -e "${fin} ZoneMinder Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} Start${nc}"
        echo -e "${fin}   2)${msg} Stop${nc}"
        echo -e "${fin}   3)${msg} Restart${nc}"
        echo -e "${fin}   4)${msg} Enable Auto Start${nc}"
        echo -e "${fin}   5)${msg} Disable Auto Start${nc}"
        echo " "
        echo -e "${ca}  a) About ZoneMinder${nc}"
        echo -e "${ca}  i) More Info / How-To's (Currently Unavailable)${nc}"
        echo -e "${ca}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  b) Back${nc} |${emp} m) Main Menu"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1')	printf '\033\143'; echo -e "${inf} Installing..${nc}" ; echo " "
					. $scriptPath/Security/Surveillance/ZoneMinder/install.sh ;;

            'a')	printf '\033\143'; . $scriptPath/Security/Surveillance/ZoneMinder/about.sh ;;
            'h')	printf '\033\143'; (. $scriptPath/gethelp.sh);;
            'i')	printf '\033\143'; . $scriptPath/Security/Surveillance/ZoneMinder/moreinfo.sh ;;
            's')	printf '\033\143'; . $scriptPath/Security/Surveillance/ZoneMinder/manage.sh ;;

            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;

            *)		echo -e "${alt}        Invalid choice, please try again${nc}" ; echo " " ;;
        esac
done
}

zoneminder.submenu

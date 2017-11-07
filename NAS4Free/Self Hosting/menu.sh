#------------------------------------------------------------------------------#
### SELF HOSTING SUBMENU

selfhosting.submenu ()
{
while [ "$choice" != "a,h,i,m,q" ]
do
        echo -e "${sep}"
        echo -e "${fin} Self Hosting Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one: Host Your Own...${nc}"
        echo " "
        echo -e "${ca}   1)${ca} Web Server (Currently Unavailable)${nc}"
        echo -e "${fin}   2)${msg} Cloud Storage (${lbt}OwnCloud${nc} / ${lbt}Pydio${nc})${nc}"
        echo -e "${ca}   3)${ca} Game Server(s) (Currently Unavailable)${nc}"
        echo -e "${ca}   4)${ca} Voice Servers ${nc}(Teamspeak / Mumble / Vent) (Currently Unavailable)${nc}"
        echo " "
        echo -e "${ca}  a) About Self Hosting (Currently Unavailable)${nc}"
        echo -e "${ca}  i) More Info / How-To's (Currently Unavailable)${nc}"
        echo -e "${inf}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  b) Back${nc} |${emp} m) Main Menu"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1')	printf '\033\143'; echo -e "${inf} Taking you to the Web Server menu..${nc}" ; echo " "
					. $scriptPath/"Self Hosting/Web Server"/menu.sh ;;
            '2') 	printf '\033\143'; echo -e "${inf} Taking you to the Cloud Services menu..${nc}" ; echo " "
                	. $scriptPath/"Self Hosting"/Cloud/menu.sh ;;
            '3')	printf '\033\143'; . $scriptPath/"Self Hosting/Game Servers"/menu.sh ;;
            '4')	printf '\033\143'; . $scriptPath/VOIP/menu.sh ;;
			
            'a')	printf '\033\143'; . $scriptPath/about.sh ;;
            'h')	printf '\033\143'; . $scriptPath/gethelp.sh ;;
            'i')	printf '\033\143'; . $scriptPath/Info/menu.sh ;;
			
			'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;
					
            *)		echo -e "${alt}        Invalid choice, please try again${nc}" ; echo " " ;;
			
        esac
done
}

selfhosting.submenu
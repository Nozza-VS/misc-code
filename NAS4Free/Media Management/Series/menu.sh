#------------------------------------------------------------------------------#
### Media Management / DOWNLOAD AUTOMATION SUBMENU

searchtools.submenu ()
{
while [ "$choice" != "a,h,i,m,q" ]
do
        echo -e "${sep}"
        echo -e "${fin} Automation Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Automate your downloads with:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} Sonarr (Preferred)${nc}"
        echo -e "${ca}   2)${ca} Sickbeard${nc}"
        echo " "
        echo -e "${ca}  a) About Automation (Currently Unavailable)${nc}"
        echo -e "${ca}  i) More Info / How-To's (Currently Unavailable)${nc}"
        echo -e "${inf}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  b) Back${nc} |${emp} m) Main Menu"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1')	echo -e "${inf} Taking you to the Sonarr menu..${nc}" ; echo " "
                		. $scriptPath/"Media Management"/Series/Sonarr/menu.sh ;;
            '2') 	echo -e "${inf} Taking you to the Sickbeard menu..${nc}" ; echo " "
                		. $scriptPath/"Media Management"/Series/Sickbeard/menu.sh ;;

            #'a')	. $scriptPath/"Media Management"/about.searchtools ;;
            'h')	printf '\033\143'; (. $scriptPath/gethelp.sh);;
            #'i')	. $scriptPath/"Media Management"/moreinfo.submenu.searchtools ;;

            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;

            *)		echo -e "${alt}        Invalid choice, please try again${nc}" ; echo " " ;;

        esac
done
}

searchtools.submenu

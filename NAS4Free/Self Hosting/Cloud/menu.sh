#------------------------------------------------------------------------------#
### CLOUD SUBMENU

cloud.submenu ()
{
while [ "$choice" != "a,h,i,b" ]
do
        echo -e "${sep}"
        echo -e "${fin} Self Hosted Cloud Storage Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} OwnCloud${nc}"
        echo -e "${fin}   2)${msg} NextCloud (Preferred)${nc}"
        echo -e "${ca}   3)${ca} Pydio (Currently Unavailable)${nc}"
        echo " "
        echo -e "${ca}  a) About Cloud Storage (Currently Unavailable)${nc}"
		echo -e "${ca}  d) Difference between ownCloud / NextCloud${nc}"
        echo -e "${ca}  i) More Information / How-To's${nc}"
        echo -e "${inf}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  b) Back${nc} |${emp} m) Main Menu"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1')	printf '\033\143'; . $scriptPath/"Self Hosting"/Cloud/Owncloud/menu.sh ;;
            '2')	printf '\033\143'; . $scriptPath/"Self Hosting"/Cloud/Nextcloud/menu.sh ;;
            '3')	printf '\033\143'; . $scriptPath/"Self Hosting"/Cloud/Pydio/menu.sh ;;
			
			'd')	printf '\033\143'; . $scriptPath/"Self Hosting"/Cloud/differences.sh ;;
			
            'a')	(. $scriptPath/"Self Hosting"/Cloud/about.sh) ;;
            'h')	printf '\033\143'; (. $scriptPath/gethelp.sh);;
			#'i')	moreinfo.submenu.sh ;;
			
            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;
					
            *)		echo -e "${alt}        Invalid choice, please try again${nc}" ; echo " " ;;
			
        esac
done
}

cloud.submenu
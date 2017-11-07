#------------------------------------------------------------------------------#
### NEXTCLOUD SUBMENU

nextcloud.submenu ()
{
while [ "$choice" != "a,h,i,b,d" ]
do
        echo -e "${sep}"
        echo -e "${fin} NextCloud Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} Install${nc}"
        echo -e "${ca}   2)${ca} Update${nc}"
        echo -e "${ca}   3)${ca} Backup${nc}"
        echo " "
        echo -e "${inf}  a) About NextCloud${nc}"
        echo -e "${inf}  i) More Info / How-To's${nc}"
        echo -e "${inf}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  b) Back${nc} |${emp} m) Main Menu"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1') 	printf '\033\143'; echo -e "${inf} Installing..${nc}" ; echo " "
                	. $scriptPath/"Self Hosting"/Cloud/Nextcloud/install.sh ;;
            #'2') 	printf '\033\143'; echo -e "${inf} Running Update..${nc}" ; echo " "
            #    	. $scriptPath/"Self Hosting"/Cloud/Nextcloud/update.sh ;;
            #'3')	printf '\033\143'; echo -e "${inf} Backup..${nc}" ; echo " "
            #    	. $scriptPath/"Self Hosting"/Cloud/Nextcloud/backup.sh ;;
					
            '4')	. $scriptPath/"Self Hosting"/Cloud/errorfix.sh ;;
            '5')	. $scriptPath/"Self Hosting"/Cloud/other.sh ;;
			
            'a')	. $scriptPath/"Self Hosting"/Cloud/Nextcloud/about.sh ;;
            'i')	. $scriptPath/"Self Hosting"/Cloud/Nextcloud/info.sh ;;
            'h')	printf '\033\143'; (. $scriptPath/gethelp.sh);;
			
            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;
					
            *)		echo -e "${alt}        Invalid choice, please try again${nc}" ; echo " " ;;
			
        esac
done
}

nextcloud.submenu
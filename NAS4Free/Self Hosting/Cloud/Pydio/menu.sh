#------------------------------------------------------------------------------#
### PYDIO SUBMENU

pydio.submenu ()
{
while [ "$choice" != "a,h,i,m,q" ]
do
        echo -e "${sep}"
        echo -e "${fin} Pydio Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} Install${nc}"
        echo -e "${fin}   2)${msg} Update${nc}"
        echo -e "${fin}   3)${msg} Backup${nc}"
        echo " "
        echo -e "${inf}  a) About Pydio${nc}"
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
                	. $scriptPath/"Self Hosting"/Cloud/Pydio/install.sh ;;
            '2') 	printf '\033\143'; echo -e "${inf} Running Update..${nc}" ; echo " "
                	. $scriptPath/"Self Hosting"/Cloud/Pydio/update.sh ;;
            '3')	printf '\033\143'; echo -e "${inf} Backup..${nc}" ; echo " "
                	. $scriptPath/"Self Hosting"/Cloud/Pydio/backup.sh ;;
					
            'a')	printf '\033\143'; . $scriptPath/"Self Hosting"/Cloud/Pydio/about.sh ;;
            'h')	printf '\033\143'; (. $scriptPath/gethelp.sh) ;;
			'i')	printf '\033\143'; . $scriptPath/"Self Hosting"/Cloud/Pydio/info.sh ;;
			
            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;
					
            *)		echo -e "${alt}        Invalid choice, please try again${nc}" ; echo " " ;;
			
        esac
done
}

pydio.submenu
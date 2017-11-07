#------------------------------------------------------------------------------#
### THEBRIG SUBMENU

thebrig.submenu ()
{
while [ "$choice" != "a,e,h,i,m" ]
do
        echo -e "${sep}"
        echo -e "${fin} TheBrig Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} Install (Guide Only)${nc}"
        echo -e "${ca}   2)${ca} Backup (Currently Unavailable)${nc}"
        echo " "
        echo -e "${inf}  a) About TheBrig${nc}"
        echo -e "${inf}  i) More Info / How-To's${nc}"
        echo -e "${inf}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  b) Back${nc} |${emp} m) Main Menu"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1')	echo -e "${inf} Taking you to install instructions..${nc}" ; echo " "
					. $scriptPath/TheBrig/thebrig.howto.installthebrig.sh ;;
            #'2') 	echo -e "${inf} Backup..${nc}" ; echo " "
            #    	backup.thebrig ;;

            'a')	. $scriptPath/TheBrig/about.sh ;;
            'h')	printf '\033\143'; (. $scriptPath/gethelp.sh);;
            'i')	. $scriptPath/TheBrig/info.sh ;;

            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;

            *)   echo -e "${alt}        Invalid choice, please try again${nc}"
                echo " "
                ;;
        esac
done
}

thebrig.submenu

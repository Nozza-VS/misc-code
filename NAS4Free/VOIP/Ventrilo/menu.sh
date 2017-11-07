#------------------------------------------------------------------------------#
### VENTRILO SERVER SUBMENU

ventrilo.submenu ()
{
while [ "$choice" != "a,h,i,b,m,q" ]
do
        echo -e "${sep}"
        echo -e "${fin} Ventrilo${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${ca}   1)${ca} Install (Currently Unavailable)${nc}"
        echo -e "${ca}   2)${ca} Update (Currently Unavailable)${nc}"
        echo -e "${ca}   3)${ca} Backup (Currently Unavailable)${nc}"
        echo " "
        echo -e "${inf}  a) About Ventrilo${nc}"
        echo -e "${ca}  i) More Information (Currently Unavailable)${nc}"
        echo -e "${inf}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  b) Back${nc} |${emp} m) Main Menu"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1')	printf '\033\143'; echo -e "${inf} Please confirm that you wish to install Ventrilo${nc}" ; echo " "
					. $scriptPath/VOIP/Ventrilo/install.sh ;;
            '2') 	printf '\033\143'; echo -e "${inf} Running Update..${nc}" ; echo " "
					. $scriptPath/VOIP/Ventrilo/update.sh ;;
            '3')	printf '\033\143'; echo -e "${inf} Backup..${nc}" ; echo " "
					. $scriptPath/VOIP/Ventrilo/backup.sh ;;

            'a')	printf '\033\143'; . $scriptPath/VOIP/Ventrilo/about.sh ;;
            'h')	printf '\033\143'; (. $scriptPath/gethelp.sh);;
			'i')	printf '\033\143'; . $scriptPath/VOIP/Ventrilo/info.sh ;;

            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;

            *)		echo -e "${alt}        Invalid choice, please try again${nc}" ; echo " " ;;

        esac
done
}

ventrilo.submenu

#------------------------------------------------------------------------------#
### HTPCManager SUBMENU

htpcmanager.submenu ()
{
while [ "$choice" != "a,h,i,m,q" ]
do
        echo -e "${sep}"
        echo -e "${fin} HTPC Manager Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${ca}   1)${ca} Install (Currently Unavailable)${nc}"
        echo -e "${ca}   2)${ca} Update (Currently Unavailable)${nc}"
        echo -e "${ca}   3)${ca} Backup (Currently Unavailable)${nc}"
        echo " "
        echo -e "${ca}  a) About NZBHydra (Currently Unavailable)${nc}"
        echo -e "${ca}  i) More Info / How-To's (Currently Unavailable)${nc}"
        echo -e "${inf}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  b) Back${nc} |${emp} m) Main Menu"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1')	printf '\033\143'; echo -e "${inf} Installing..${nc}" ; echo " "
					. $scriptPath/"Download Tools"/HTPCManager/install.sh ;;
            '2') 	printf '\033\143'; echo -e "${inf} Running Update..${nc}" ; echo " "
                	. $scriptPath/"Download Tools"/HTPCManager/update.sh ;;
            #'3') 	printf '\033\143'; echo -e "${inf} Backup..${nc}" ; echo " "
            #    	. $scriptPath/"Download Tools"/HTPCManager/backup.sh ;;

			'a')	printf '\033\143'; . $scriptPath/"Download Tools"/HTPCManager/about.sh ;;
            'h')	printf '\033\143'; (. $scriptPath/gethelp.sh);;
            #'i')	printf '\033\143'; . $scriptPath/"Download Tools"/HTPCManager/moreinfo.sh ;;

            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;

            *)		echo -e "${alt}        Invalid choice, please try again${nc}" ; echo " " ;;

        esac
done
}

nzbhydra.submenu

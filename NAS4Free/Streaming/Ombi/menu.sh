#------------------------------------------------------------------------------#
### OMBI SERVER SUBMENU

ombi.submenu ()
{
while [ "$choice" != "a,h,i,b,q" ]
do
        echo -e "${sep}"
        echo -e "${fin} Ombi Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} Install${nc}"
        echo -e "${ca}   2)${ca} Update (Currently Unavailable)${nc}"
        echo -e "${ca}   3)${ca} Backup (Currently Unavailable)${nc}"
        echo " "
        echo -e "${ca}  a) About Ombi${nc}"
        echo -e "${ca}  i) More Info / How-To's (Currently Unavailable)${nc}"
        echo -e "${ca}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  b) Back${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1')	printf '\033\143'; echo -e "${inf} Installing..${nc}" ; echo " "
					. $scriptPath/Streaming/Ombi/install.sh ;;
            '2')	printf '\033\143'; echo -e "${inf} Running Update..${nc}" ; echo " "
                	. $scriptPath/Streaming/Ombi/update.sh ;;
            '3')	printf '\033\143'; echo -e "${inf} ..${nc}" ; echo " "
					. $scriptPath/Streaming/Ombi/backup.sh ;;

            'a')	printf '\033\143'; . $scriptPath/Streaming/Ombi/about.sh ;;
            'h')	printf '\033\143'; (. $scriptPath/gethelp.sh);;
            'i')	printf '\033\143'; . $scriptPath/Streaming/Ombi/moreinfo.sh ;;

            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;

            *)		echo -e "${alt}        Invalid choice, please try again${nc}" ; echo " " ;;
        esac
done
}

ombi.submenu

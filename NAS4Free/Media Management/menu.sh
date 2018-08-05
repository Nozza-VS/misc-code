#------------------------------------------------------------------------------#
### Media Management / DOWNLOAD AUTOMATION SUBMENU

managemedia.submenu ()
{
while [ "$choice" != "a,h,i,m,q" ]
do
        echo -e "${sep}"
        echo -e "${fin} Automation Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Automate your downloads with:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} TV/Anime Series${nc}"
        echo -e "${ca}   2)${ca} Movies${nc}"
        echo -e "${fin}   3)${msg} Music${nc}"
        echo -e "${ca}   4)${ca} Books${nc}"
        echo " "
        echo -e "${ca}   0)${ca} HTPC Manager${nc}"
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
            '1')	echo -e "${inf} Taking you to the Series menu..${nc}" ; echo " "
                		. $scriptPath/"Media Management"/Series/menu.sh ;;
            '2') 	echo -e "${inf} Taking you to the Movies menu..${nc}" ; echo " "
                		. $scriptPath/"Media Management"/Movies/menu.sh ;;
			'3') 	echo -e "${inf} Taking you to the Music menu..${nc}" ; echo " "
                		. $scriptPath/"Media Management"/Music/menu.sh ;;
            '4') 	echo -e "${inf} Taking you to the Books menu..${nc}" ; echo " "
                		. $scriptPath/"Media Management"/Books/menu.sh ;;
            #'0') 	echo -e "${inf} Taking you to the HTPC Manager menu..${nc}" ; echo " "
            #    		. $scriptPath/"Media Management"/HTPCManager/menu.sh ;;

            #'a')	. $scriptPath/"Media Management"/about.searchtools ;;
            'h')	printf '\033\143'; (. $scriptPath/gethelp.sh);;
            #'i')	. $scriptPath/"Media Management"/moreinfo.submenu.searchtools ;;

            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;

            *)		echo -e "${alt}        Invalid choice, please try again${nc}" ; echo " " ;;

        esac
done
}

managemedia.submenu

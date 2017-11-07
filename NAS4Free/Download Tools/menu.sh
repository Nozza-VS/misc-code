#------------------------------------------------------------------------------#
### DOWNLOAD TOOLS SUBMENU

while [ "$choice" != "a,h,i,m,q" ]
do
        echo -e "${sep}"
        echo -e "${fin} Download Tools${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} Deluge (Torrenting)${nc}"
        echo -e "${fin}   2)${msg} NZBGet (Usenet Downloader)${nc}"
        echo -e "${fin}   3)${msg} SABnzbd (Usenet Downloader)${nc}"
        echo " "
        echo -e "${fin}   4)${msg} Jackett (Torrent Meta Search)${nc}"
        echo -e "${fin}   5)${msg} NZBHydra (Usenet Meta Search)${nc}"
        echo " "
        echo -e "${ca}  i) More Info / How-To's (Currently Unavailable)${nc}"
        echo -e "${inf}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  b) Back${nc} |${emp} m) Main Menu"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1')	printf '\033\143'; . $scriptPath/"Download Tools"/Deluge/menu.sh ;;
            '2')	printf '\033\143'; . $scriptPath/"Download Tools"/NZBGet/menu.sh ;;
            '3')	printf '\033\143'; . $scriptPath/"Download Tools"/SABnzbd/menu.sh ;;
            '4')	printf '\033\143'; . $scriptPath/"Download Tools"/Jackett/menu.sh ;;
            '5')	printf '\033\143'; . $scriptPath/"Download Tools"/NZBHydra/menu.sh ;;
			
            'i') 	printf '\033\143'; moreinfo.submenu.downloadtools ;;
            'h')	printf '\033\143'; gethelp ;;
			
            'b') 	printf '\033\143'; return ;;
			'm') 	printf '\033\143'; . $scriptPath/mainmenu.sh ;;
			
            *)		echo -e "${alt}        Invalid choice, please try again${nc}"
                	echo " "
                	;;
        esac
done
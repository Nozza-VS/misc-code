#------------------------------------------------------------------------------#
### SEARCH TOOLS / DOWNLOAD AUTOMATION SUBMENU

searchtools.submenu ()
{
while [ "$choice" != "a,h,i,m,q" ]
do
        echo -e "${sep}"
        echo -e "${fin} Automation Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Automate your downloads with:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} Sonarr (TV & Anime) (Preferred)${nc}"
        echo -e "${ca}   2)${ca} Sickbeard (TV & Anime) (Currently Unavailable)${nc}"
        echo -e "${fin}   3)${msg} CouchPotato (Movies)${nc}"
        echo -e "${ca}   4)${ca} Watcher (Movies)${nc}"
        echo -e "${ca}   5)${ca} Radarr (Sonarr for Movies)${nc}"
        echo -e "${fin}   6)${msg} HeadPhones (Music) (Currently Unavailable)${nc}"
        echo -e "${ca}   7)${ca} Mylar (Comics) (Currently Unavailable)${nc}"
        echo -e "${ca}   8)${ca} LazyLibrarian (Books) (Currently Unavailable)${nc}"
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
            '1')	echo -e "${inf} Taking you to the Sonarr menu..${nc}" ; echo " "
                	. $scriptPath/"Search Tools"/Sonarr/menu.sh ;;
            #'2') 	echo -e "${inf} Taking you to the Sickbeard menu..${nc}" ; echo " "
            #    	. $scriptPath/"Search Tools"/Sickbeard/menu.sh ;;
            '3') 	echo -e "${inf} Taking you to the CouchPotato menu..${nc}" ; echo " "
                	. $scriptPath/"Search Tools"/Couchpotato/menu.sh ;;
            '4') 	echo -e "${inf} Taking you to the HeadPhones menu..${nc}" ; echo " "
                	. $scriptPath/"Search Tools"/Headphones/menu.sh ;;
            #'5') 	echo -e "${inf} Taking you to the Mylar menu..${nc}" ; echo " "
            #    	. $scriptPath/"Search Tools"/Mylar/menu.sh ;;
            #'6') 	echo -e "${inf} Taking you to the LazyLibrarian menu..${nc}" ; echo " "
            #    	. $scriptPath/"Search Tools"/Lazylibrarian/menu.sh ;;
            #'0') 	echo -e "${inf} Taking you to the HTPC Manager menu..${nc}" ; echo " "
            #    	. $scriptPath/"Search Tools"/HTPCManager/menu.sh ;;
			
            #'a')	. $scriptPath/"Search Tools"/about.searchtools ;;
            'h')	printf '\033\143'; (. $scriptPath/gethelp.sh);;
            #'i')	. $scriptPath/"Search Tools"/moreinfo.submenu.searchtools ;;
			
            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;
			
            *)		echo -e "${alt}        Invalid choice, please try again${nc}" ; echo " " ;;
			
        esac
done
}

searchtools.submenu
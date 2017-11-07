#------------------------------------------------------------------------------#
### TEAMSPEAK SERVER SUBMENU

teamspeak3.submenu ()
{
while [ "$choice" != "a,h,i,b,q" ]
do
        echo -e "${sep}"
        echo -e "${fin} Teamspeak 3 Server Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} Install${nc}"
        echo -e "${ca}   2)${ca} Update${nc}"
        echo -e "${ca}   3)${ca} Backup${nc}"
        echo " "
        echo -e "${ca}   4)${ca} Install JTS3ServerMod [Server Bot] (Currently Unavailable)${nc}" # (Use above install first)
        echo -e "${ca}   5)${ca} Update JTS3ServerMod [Server Bot] (Currently Unavailable)${nc}" # (Use above install first)
        echo " "
        echo -e "${ca}  a) About Teamspeak${nc}"
        echo -e "${ca}  i) More Info / How-To's${nc}"
        echo -e "${inf}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  b) Back${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

		case $choice in
            '1')	printf '\033\143'; echo -e "${inf} Please confirm that you wish to install Ventrilo${nc}" ; echo " "
					. $scriptPath/VOIP/Teamspeak/install.sh ;;
            '2') 	printf '\033\143'; echo -e "${inf} Running Update..${nc}" ; echo " "
					. $scriptPath/VOIP/Teamspeak/update.sh ;;
            '3')	printf '\033\143'; echo -e "${inf} Backup..${nc}" ; echo " "
					. $scriptPath/VOIP/Teamspeak/backup.sh ;;
			#'4')	printf '\033\143'; echo -e "${inf} Installing..${nc}" ; echo " "
            #    	. $scriptPath/VOIP/Teamspeak/teamspeak3bot ;;
            #'5') 	printf '\033\143'; echo -e "${inf} Updating..${nc}" ; echo " "
            #    	. $scriptPath/VOIP/Teamspeak/teamspeak3bot ;;

            'a')	printf '\033\143'; . $scriptPath/VOIP/Teamspeak/about.sh ;;
            'h')	printf '\033\143'; (. $scriptPath/gethelp.sh);;
			'i')	printf '\033\143'; . $scriptPath/VOIP/Teamspeak/info.sh ;;

            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;

            *)		echo -e "${alt}        Invalid choice, please try again${nc}" ; echo " " ;;

        esac
done
}

teamspeak3.submenu

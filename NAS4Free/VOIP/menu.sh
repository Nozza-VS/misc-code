#------------------------------------------------------------------------------#
### VOICE SERVERS SUBMENU

while [ "$choice" != "a,h,i,b,q" ]
do
        echo -e "${sep}"
        echo -e "${fin} Voice Server Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} Teamspeak${nc}"
        echo -e "${ca}   2)${ca} Ventrilo${nc}"
        echo -e "${ca}   3)${ca} Murmur (Mumble)${nc}"
        echo " "
        echo -e "${inf}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  b) Back${nc} |${emp} m) Main Menu"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1')	printf '\033\143'; (. $scriptPath/VOIP/Teamspeak/menu.sh) ;;
            '2') 	printf '\033\143'; (. $scriptPath/VOIP/Ventrilo/menu.sh) ;;
            '3') 	printf '\033\143'; (. $scriptPath/VOIP/Murmur/menu.sh) ;;

            'h')	printf '\033\143'; (. $scriptPath/help/gethelp.sh) ;;

            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;

            *)		echo -e "${alt}        Invalid choice, please try again${nc}"
                	echo " " ;;
        esac
done

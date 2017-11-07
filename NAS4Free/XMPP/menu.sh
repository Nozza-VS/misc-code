### XMPP SUBMENU
#------------------------------------------------------------------------------#

while [ "$choice" != "a,h,i,b,m,q" ]
do
        echo -e "${sep}"
        echo -e "${fin} XMPP${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} eJabberd${nc}"
        echo -e "${fin}   2)${msg} Prosody${nc}"
        echo " "
        echo -e "${inf}  a) About XMPP${nc}"
        echo -e "${ca}  i) More Information (Currently Unavailable)${nc}"
        echo -e "${inf}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  b) Back${nc} |${emp} m) Main Menu"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1')	echo -e "${inf} Please confirm that you wish to install eJabberd${nc}" ; echo " "
					. $scriptPath/XMPP/Ejabberd/menu.sh ;;
            '2') 	echo -e "${inf} Please confirm that you wish to install Prosody${nc}" ; echo " "
					. $scriptPath/XMPP/Prosody/menu.sh ;;

            'a')	. $scriptPath/XMPP/about.sh ;;
            'i')	. $scriptPath/XMPP/info.sh ;;
            'h')	printf '\033\143'; (. $scriptPath/gethelp.sh);;

            'b') 	return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;

            *)   	echo -e "${alt}        Invalid choice, please try again${nc}"
                	echo " "
                	;;
        esac
done

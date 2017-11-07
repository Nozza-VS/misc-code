### Ejabberd SUBMENU
#------------------------------------------------------------------------------#

while [ "$choice" != "a,h,i,b,m,q" ]
do
        echo -e "${sep}"
        echo -e "${fin} XMPP - Ejabberd${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} Install Ejabberd${nc}"
        echo -e "${fin}   2)${msg} Update Ejabberd${nc}"
        echo -e "${ca}   3)${ca} Backup (Currently Unavailable)${nc}"
        echo " "
        echo -e "${inf}  a) About Ejabberd${nc}"
        echo -e "${ca}  i) More Information (Currently Unavailable)${nc}"
        echo -e "${inf}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  b) Back${nc} |${emp} m) Main Menu"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1')	echo -e "${inf} Please confirm that you wish to install Ejabberd${nc}" ;; echo " "
					. $scriptPath/XMPP/Ejabberd/install.sh ;;
            '2') 	echo -e "${inf} Running Update..${nc}" ;; echo " "
					. $scriptPath/XMPP/Ejabberd/update.sh ;;
            '3')	echo -e "${inf} Backup..${nc}" ;; echo " "
					. $scriptPath/XMPP/Ejabberd/backup.sh ;;

            'a')	about.ejabberd ;;
            'i')	moreinfo.submenu.ejabberd ;;
            'h')	printf '\033\143'; (. $scriptPath/gethelp.sh);;

            'b') 	return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;

            *)   	echo -e "${alt}        Invalid choice, please try again${nc}" ;; echo " " ;;
        esac
done

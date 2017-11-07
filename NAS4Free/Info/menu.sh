#------------------------------------------------------------------------------#
### MORE INFORMATION / HOW-TO / FURTHER INSTRUCTIONS SUBMENU (COMBINED)

moreinfo.submenu ()
{
while [ "$choice" != "m" ]
do
        echo -e "${sep}"
        echo -e "${inf} More Info / How-To's Top Menu"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${msg} More info & how-to's about..."
        echo -e "${fin}   1)${msg} OwnCloud"
        echo -e "${fin}   2)${msg} TheBrig (Jails)"
        echo -e "${fin}   3)${msg} Emby"
        echo " "
        echo -e "${emp}  b) Back${nc} |${emp} m) Main Menu"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1')	printf '\033\143'; . $scriptPath/Info/owncloud.sh ;;
            '2')	printf '\033\143'; . $scriptPath/Info/thebrig.sh ;;
            '3')	printf '\033\143'; . $scriptPath/Info/emby.sh ;;

            'b')	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;

            *)   	echo -e "${alt}        Invalid choice, please try again${nc}"
                	echo " "
                	;;
        esac
done
}

moreinfo.submenu

#------------------------------------------------------------------------------#
### SYSTEM TOOLS SUBMENU

systemtools.submenu ()
{
while [ "$choice" != "a,e,h,i,m" ]
do
        echo -e "${sep}"
        echo -e "${fin} TheBrig Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} Install (Guide Only)${nc}"
        echo " "
        echo -e "${inf}  a) About TheBrig${nc}"
        echo -e "${inf}  i) More Info / How-To's${nc}"
        echo -e "${inf}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  m) Main Menu${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1') echo -e "${inf} Taking you to install instructions..${nc}"
                echo " "
                thebrig.howto.installthebrig
                ;;

            'a')	about.thebrig ;;
            'h')	gethelp ;;
            'i')	moreinfo.submenu.thebrig ;;

            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;

            *)   echo -e "${alt}        Invalid choice, please try again${nc}"
                echo " "
                ;;
        esac
done
}

thebrig.submenu

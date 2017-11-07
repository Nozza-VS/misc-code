#------------------------------------------------------------------------------#
### OBI SUBMENU

obi.submenu ()
{
while [ "$choice" != "a,e,h,i,m" ]
do
        echo -e "${sep}"
        echo -e "${fin} OneButtonInstaller Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} Install${nc}"
        echo -e "${ca}   2)${ca} Update (Currently Unavailable)${nc}"
        echo " "
        echo -e "${ca}  a)${ca} About OneButtonInstaller${nc}"
        echo -e "${ca}  i)${ca} More Info / How-To's${nc}"
        echo -e "${inf}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  b) Back${nc} |${emp} m) Main Menu"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1')	printf '\033\143'; echo -e "${inf} Installing..${nc}" ; echo " "
					. $scriptPath/OBI/install.sh ;;
            #'2')	printf '\033\143'; echo -e "${inf} Running Update..${nc}" ; echo " "
            #    	. $scriptPath/OBI/update.sh ;;

            #'a')	printf '\033\143'; . $scriptPath/OBI/about.sh;;
            'h')	printf '\033\143'; (. $scriptPath/gethelp.sh);;
            #'i')	printf '\033\143'; . $scriptPath/OBI/moreinfo.sh ;;

            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;

            *)		echo -e "${alt}        Invalid choice, please try again${nc}" ; echo " " ;;

        esac
done
}

obi.submenu

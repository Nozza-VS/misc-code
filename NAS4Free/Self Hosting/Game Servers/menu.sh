#------------------------------------------------------------------------------#
### GAME SERVERS SUBMENU

gameservers.submenu ()
{
while [ "$choice" != "a,h,i,m,q" ]
do
        echo -e "${sep}"
        echo -e "${fin} Game Servers${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} Minecraft${nc}"
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
            '1')	printf '\033\143'; . $scriptPath/"Game Servers"/Minecraft/menu.sh ;;
			
            'i') 	moreinfo.submenu.downloadtools ;;
            'h')	printf '\033\143'; (. $scriptPath/gethelp.sh);;
			
            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;
					
            *)		echo -e "${alt}        Invalid choice, please try again${nc}" ; echo " " ;;
			
        esac
done
}

gameservers.submenu
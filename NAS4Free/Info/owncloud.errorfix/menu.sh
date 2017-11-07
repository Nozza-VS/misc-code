### OWNCLOUD ERROR FIXES SUBMENU
#------------------------------------------------------------------------------#

owncloud.errorfix.submenu ()
{
while [ "$choice" != "b" ]
do
        echo -e "${sep}"
        echo -e "${inf} OwnCloud - Fixes For Known Errors${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} Trusted Domain Error"
        echo -e "${fin}   2)${msg} Populating Raw Post Data Error"
        echo " "
        echo -e "${emp}   b) Back${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1') echo -e "${inf} ${nc}"
                owncloud.trusteddomain.fix
                ;;
            '2') echo -e "${inf} ${nc}"
                owncloud.phpini
                ;;
            'b') return
                ;;
            *)   echo -e "${alt}        Invalid choice, please try again${nc}"
                echo " "
                ;;
        esac
done
}

owncloud.errorfix.submenu

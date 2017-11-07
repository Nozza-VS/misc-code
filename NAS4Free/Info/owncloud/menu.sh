moreinfo.submenu.owncloud ()
{
while [ "$choice" != "m" ]
do
        echo -e "${sep}"
        echo -e "${inf} OwnCloud - Info / How-To's Menu${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${msg} How to...${nc}"
        echo -e "${fin}   1)${msg} Finish the owncloud setup${nc}"
        echo " "
        echo -e "${emp}   m) Main Menu${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1') owncloud.howto.finishsetup
                ;;
            'm') return
                ;;
            *)   echo -e "${alt}        Invalid choice, please try again${nc}"
                echo " "
                ;;
        esac
done
}

moreinfo.submenu.owncloud

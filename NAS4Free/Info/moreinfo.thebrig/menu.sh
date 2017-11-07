moreinfo.submenu.thebrig ()
{
while [ "$choice" != "b" ]
do
        echo -e "${sep}"
        echo -e "${inf} TheBrig - Info / How-To's Menu${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${msg} More info about...${nc}"
        echo -e "${fin}   1)${msg} Rudimentary Config${nc}"
        echo " "
        echo -e "${msg} How to...${nc}"
        echo -e "${fin}   2)${msg} Create a jail${nc}"
        echo -e "${fin}   3)${msg} Enable the 'Ports Tree'${nc}"
        echo -e "${fin}   4)${msg} Mount a folder in the jail via fstab${nc}"
        echo " "
        echo -e "${emp}   b) Back${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1')
                info.thebrig.rudimentaryconfig
                ;;
            '2')
                thebrig.howto.createajail
                ;;
            '3')
                thebrig.howto.enableportstree
                ;;
            '4')
                thebrig.howto.mountviafstab
                ;;
            'b') return
                ;;
            *)   echo -e "${alt}        Invalid choice, please try again${nc}"
                echo " "
                ;;
        esac
done
}

moreinfo.submenu.thebrig

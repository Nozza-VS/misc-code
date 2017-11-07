moreinfo.submenu.emby ()
{
while [ "$choice" != "m" ]
do
        echo -e "${sep}"
        echo -e "${inf} Emby - Info / How-To's Menu${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${msg} How to...${nc}"
        echo -e "${fin}   1)${msg} Update FFMPEG (To enable more transcoding options)"
        echo -e "${fin}   2)${msg} Update ImageMagick (To increase server performance)"
        echo " "
        echo -e "${emp}   m) Main Menu${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1') emby.howto.updateffmpeg
                ;;
            'm') return
                ;;
            *)   echo -e "${alt}        Invalid choice, please try again${nc}"
                echo " "
                ;;
        esac
done
}

moreinfo.submenu.emby

#------------------------------------------------------------------------------#
### ABOUT: DELUGE

about.deluge ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: Deluge${nc}"
        echo " "
        echo -e "${msg} Deluge is a lightweight, Free Software, cross-platform BitTorrent client.${nc}"
        echo " "
        echo -e "${msg} It provides: Full Encryption, WebUI, Plugin System & Much more${nc}"
        echo -e "${sep}"
        echo " "

        echo -e "${msep}"
        echo -e "${emp}   Press Enter To Go Back To The Menu${nc}"
        echo -e "${msep}"

        read choice

        case $choice in
            *)
                 return
                 ;;
        esac
done

}

about.deluge
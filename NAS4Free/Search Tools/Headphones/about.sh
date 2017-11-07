#------------------------------------------------------------------------------#
### ABOUT: HEADPHONES

about.headphones ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: Headphones${nc}"
        echo " "
        echo -e "${msg} Headphones is an automated music downloader for NZB and Torrent, written in${nc}"
        echo -e "${msg} Python. It supports SABnzbd, NZBget, Transmission, µTorrent, Deluge and${nc}"
        echo -e "${msg} Blackhole.${nc}"
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

about.headphones
#------------------------------------------------------------------------------#
### ABOUT: SONARR

about.sonarr ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: Sonarr (Formerly NZBDrone)${nc}"
        echo " "
        echo -e "${msg} Sonarr is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS${nc}"
        echo -e "${msg} feeds for new episodes of your favorite shows and  will grab, sort and rename${nc}"
        echo -e "${msg} them. It can also be configured to  automatically upgrade the quality of files${nc}"
        echo -e "${msg} already downloaded  when a better quality format becomes available.${nc}"
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

about.sonarr
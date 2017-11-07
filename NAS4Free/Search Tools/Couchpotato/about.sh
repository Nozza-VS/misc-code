#------------------------------------------------------------------------------#
### ABOUT: COUCHPOTATO

about.couchpotato ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: CouchPotato${nc}"
        echo " "
        echo -e "${msg} CouchPotato (CP) is an automatic NZB and torrent downloader.${nc}"
        echo -e "${msg} You can keep a 'movies I want'-list and it will search for NZBs/torrents${nc}"
        echo -e "${msg} of these movies every X hours. Once a movie is  found, it will send it to${nc}"
        echo -e "${msg} SABnzbd/NZBGet or download the torrent to a specified directory.${nc}"
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

about.couchpotato
#------------------------------------------------------------------------------#
### ABOUT: PLEX MEDIA SERVER

about.plex ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: Plex Media Server${nc}"
        echo " "
        echo -e "${msg} Plex organizes all of your personal media so you can enjoy it,${nc}"
        echo -e "${msg} no matter where you are.${nc}"
        echo " "
        echo -e "${msg} Plex's front-end media player, Plex Media Player (formerly Plex Home Theater),${nc}"
        echo -e "${msg} allows the user to manage and play audiobooks, music, photos, podcasts, and${nc}"
        echo -e "${msg} videos from a local or remote computer running Plex Media Server. Additionally,${nc}"
        echo -e "${msg} the integrated Plex Online service provides the user with a growing list of${nc}"
        echo -e "${msg} community-driven plugins for online content such as Netflix, Hulu, etc.${nc}"
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

about.plex

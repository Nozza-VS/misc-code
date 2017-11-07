#------------------------------------------------------------------------------#
### EMBY - HOW-TO: RESTART THE SERVER

emby.howto.restartserver ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} Emby - How to restart your server${nc}"
        echo -e "${sep}"
        echo " "
        echo -e "${msg} If you need to restart the server, you can with:${nc}"
        echo -e "${cmd}    service emby-server restart${nc}"
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

emby.howto.restartserver

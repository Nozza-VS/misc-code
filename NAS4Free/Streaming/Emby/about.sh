#------------------------------------------------------------------------------#
### ABOUT: EMBY SERVER

about.emby ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: Emby Media Server${nc}"
        echo " "
        echo -e "${msg} Emby Server is a home media server built on top of other popular open source${nc}"
        echo -e "${msg} technologies such as Service Stack, jQuery, jQuery  mobile, and Mono.${nc}"
        echo " "
        echo -e "${msg} It features a REST-based API with built-in documention to  facilitate client${nc}"
        echo -e "${msg} development. It also has client libraries for API to enable rapid development.${nc}"
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

about.emby

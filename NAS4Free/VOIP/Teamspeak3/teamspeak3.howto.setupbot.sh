#------------------------------------------------------------------------------#
### TEAMSPEAK 3 SERVER - HOW-TO: Set up the server bot
#------------------------------------------------------------------------------#

teamspeak3.howto.setupbot ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} Emby - How to set up the server bot:"
        echo -e "${sep}"
        echo " "
        echo -e "${msg} ${nc}"
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

teamspeak3.howto.setupbot

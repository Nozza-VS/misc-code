#------------------------------------------------------------------------------#
### ABOUT: TEAMSPEAK 3

about.teamspeak3 ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: Teamspeak 3${nc}"
        echo " "
        echo -e "${msg} ${nc}"
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

about.teamspeak3

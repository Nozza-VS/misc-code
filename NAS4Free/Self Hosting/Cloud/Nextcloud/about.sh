#------------------------------------------------------------------------------#
### ABOUT: NEXTCLOUD

about.nextcloud ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: NextCloud${nc}"
        echo " "
        echo -e "${emp} 'About: NextCloud' hasn't been added to this script yet :(${nc}"
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

about.nextcloud
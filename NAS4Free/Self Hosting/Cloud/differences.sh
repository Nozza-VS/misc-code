#------------------------------------------------------------------------------#
### ABOUT: NEXTCLOUD / OWNCLOUD DIFFERENCES

about.cloud.differences ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: Difference between NextCloud & ownCloud${nc}"
        echo " "
        echo -e "${emp} This info hasn't been added to this script yet :(${nc}"
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

about.cloud.differences
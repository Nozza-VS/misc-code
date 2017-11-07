#------------------------------------------------------------------------------#
### ABOUT: CLOUD STORAGE

about.cloudstorage ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: Cloud Storage${nc}"
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

about.cloudstorage
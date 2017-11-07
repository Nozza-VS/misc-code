#------------------------------------------------------------------------------#
### ABOUT: NZBGET

while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: NZBGet${nc}"
        echo " "
        echo -e "${msg} NZBGet is a binary downloader, which downloads files from Usenet based on${nc}"
        echo -e "${msg} information given in nzb-files.${nc}"
        echo " "
        echo -e "${msg} NZBGet is written in C++ and is known for its extraordinary performance and${nc}"
        echo -e "${msg} efficiency.${nc}"
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
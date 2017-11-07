#------------------------------------------------------------------------------#
### ABOUT: SABNZBD

while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: SABnzbd${nc}"
        echo " "
        echo -e "${msg} SABnzbd makes Usenet as simple and streamlined as possible by automating${nc}"
        echo -e "${msg} everything we can. All you have to do is add an .nzb. SABnzbd takes over from${nc}"
        echo -e "${msg} there, where it will be automatically downloaded, verified, repaired, extracted${nc}"
        echo -e "${msg} and filed away with zero human interaction.${nc}"
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
#------------------------------------------------------------------------------#
### OWNCLOUD - HOW-TO: FINISH SETUP
#------------------------------------------------------------------------------#

owncloud.howto.finishsetup ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} OwnCloud - How to finalize setup${nc}"
        echo -e "${sep}"
        echo " "
        echo -e "${emp} Follow these instructions carefully${nc}"
        echo " "
        echo -e "${msg} In a web browser, head to: ${url}https://$cloud_server_ip:$cloud_server_port${nc}"
        echo " "
        echo -e "${msg} Admin Username: ${inf}Enter your choice of username${nc}"
        echo -e "${msg} Admin Password: ${inf}Enter your choice of password${nc}"
        echo " "
        echo -e "${alt}    Click Database options and choose MySQL${nc}"
        echo -e "${msg} Database username: ${inf}root${nc}"
        echo -e "${msg} Database password: ${inf}THE PASSWORD YOU ENTERED EARLIER FOR MYSQL${nc}"
        echo -e "${msg} Database host: ${inf}Leave as is (Should be localhost)${nc}"
        echo -e "${msg} Database name: ${inf}Your choice (owncloud is fine)${nc}"
        echo " "
        echo -e "${emp} Click Finish Setup, the page will take a moment to refresh${nc}"
        echo -e "${msg} After it refreshes, if you are seeing a 'Trusted Domain' error,${nc}"
        echo -e "${msg} head back to the owncloud menu and select option 4.${nc}"
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

owncloud.howto.finishsetup
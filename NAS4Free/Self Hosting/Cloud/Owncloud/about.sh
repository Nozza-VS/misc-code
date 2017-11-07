#------------------------------------------------------------------------------#
### ABOUT: OWNCLOUD

about.owncloud ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: ownCloud${nc}"
        echo " "
        echo -e "${msg} ownCloud is a self-hosted file sync & share server. It provides access to your${nc}"
        echo -e "${msg} data through a web interface, sync clients or WebDAV while providing a platform${nc}"
        echo -e "${msg} to view, sync and share across devices easily — all under your control.${nc}"
        echo " "
        echo -e "${msg} ownCloud’s open architecture is extensible via a simple but powerful API for${nc}"
        echo -e "${msg} applications and plugins and it works with any storage.${nc}"
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

about.owncloud
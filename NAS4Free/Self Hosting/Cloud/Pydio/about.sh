#------------------------------------------------------------------------------#
### ABOUT: PYDIO

about.pydio ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: Pydio${nc}"
        echo " "
        echo -e "${msg} Pydio (formely AjaXplorer) is a mature open source software solution for${nc}"
        echo -e "${msg} file sharing and synchronization. With intuitive user interfaces${nc}"
        echo -e "${msg} (web/mobile/desktop), Pydio provides enterprise-grade features to gain back${nc}"
        echo -e "${msg} control and privacy of your data. Pydio is hosted exclusively on your private${nc}"
        echo -e "${msg} server or cloud so you can rest assured that files are securely managed under your control.${nc}"
        echo -e "${msg} your control.${nc}"
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

about.pydio
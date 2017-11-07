#------------------------------------------------------------------------------#
### ABOUT: THEBRIG

about.thebrig ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: TheBrig${nc}"
        echo " "
        echo -e "${msg} thebrig is a set of PHP pages used to create & manage FreeBSD jails on NAS4Free${nc}"
        echo " "
        echo -e "${msg} The main advantage of thebrig is that it leverages the existing webgui control${nc}"
        echo -e "${msg} and accounting mechanisms found within Nas4Free, and can be used on an embedded${nc}"
        echo -e "${msg} installation.${nc}"
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

about.thebrig

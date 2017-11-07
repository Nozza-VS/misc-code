#------------------------------------------------------------------------------#
### THEBRIG - ABOUT: RUDIMENTARY CONFIGURATION
#------------------------------------------------------------------------------#

info.thebrig.rudimentaryconfig ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} TheBrig - Rudimentary Configuration"
        echo -e "${sep}"
        echo " "
        echo -e "${msg} Head to that new ${fin}Extensions->TheBrig${msg} page in your WebGUI${nc}"
        echo -e "${msg} After making sure the '${fin}Installation folder${msg}' =${fin} ${mystorage}/Jails${msg}, Click '${inf}Save${msg}'${nc}"
        echo " "
        echo -e "${msg} Now head to '${fin}Tarball Management${msg}' (Underneath 'Maintenance') > Click ${inf}Query!${nc}"
        echo -e "${msg} It should now have '${fin}10.2-RELEASE${msg}' in the new dropdown menu${nc}"
        echo -e "${msg}    (Select it if it isn't already)${nc}"
        echo -e "${msg} Tick all boxes below that ${nc}"
        echo -e "${msg}    (Only '${fin}base.txz${msg}' and '${fin}lib32.txz${msg}' are really needed${nc}"
        echo -e "${msg}     but let's grab them all just in case)${nc}"
        echo -e "${msg} Click '${inf}Fetch${msg}', wait some time for the downloads to finish${nc}"
        echo -e "${msg} Once all the download bars are gone you can proceed to making your jail${nc}"
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

info.thebrig.rudimentaryconfig

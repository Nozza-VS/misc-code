#------------------------------------------------------------------------------#
### THEBRIG - HOW-TO: CREATE A JAIL
#------------------------------------------------------------------------------#

thebrig.howto.createajail ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} TheBrig - How to create a jail${nc}"
        echo -e "${sep}"
        echo " "
        echo -e "${emp} This assumes you have installed TheBrig already and${nc}"
        echo -e "${emp} have done the initial configuration.${nc}"
        echo " "
        echo -e "${msg} Head to your NAS webgui, you should see a menu${nc}"
        echo -e "${msg} named '${inf}Extensions${msg}'. Hover over it and click '${inf}TheBrig${msg}'${nc}"
        echo -e "${msg} From here, click the '${inf}+${msg}' icon${nc}"
        echo -e "${msg} On the new page, there are some things to change${nc}"
        echo " "
        echo -e "${fin} OPTIONAL ${msg}things are: '${inf}Jail name${msg}', '${inf}Path to jail${msg}'${nc}"
        echo -e "${msg}    & '${inf}Description${msg}'${nc}"
        echo " "
        echo -e "${emp} MUST ${msg}change items are: '${inf}Jail Network settings${msg}'"
        echo -e "${msg}    & '${inf}Official FreeBSD Flavor${msg}'${nc}"
        echo " "
        echo -e "${msg} For Jail IP enter an address that is NOT your NAS IP${nc}"
        echo -e "${msg} or conflicts with any other IP on your network${nc}"
        echo -e "${msg} It must be filled out like so: ${inf}192.168.1.200/24${nc}"
        echo -e "${msg} Once you have entered your desired IP, click '${inf}<<${msg}'.${nc}"
        echo " "
        echo -e "${msg} For FreeBSD Flavor, select at least 1 of each type:${nc}"
        echo -e "${msg} '${inf}base${msg}' & '${inf}lib32${msg}'${nc}"
        echo " "
        echo -e "${msg} Now press '${inf}Add${msg}' at the bottom and that should be it!${nc}"
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

thebrig.howto.createajail

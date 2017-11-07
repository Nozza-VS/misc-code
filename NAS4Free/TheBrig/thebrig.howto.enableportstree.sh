#------------------------------------------------------------------------------#
### THEBRIG - HOW-TO: ENABLE PORTS TREE
#------------------------------------------------------------------------------#

thebrig.howto.enableportstree ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} TheBrig - How to enable the ports tree in jails:"
        echo -e "${sep}"
        echo " "
        echo -e "${msg} Head to your NAS webgui and go to '${inf}Extensions${msg}' -> '${inf}TheBrig.${nc}"
        echo -e "${msg} From here, you want to click '${inf}Updates${msg}' and then '${inf}Central Ports.${nc}"
        echo -e "${msg} First thing to do here is click '${inf}Fetch & Update${msg}'${nc}"
        echo -e "${msg} After it has done, tick the box next to the name of the jail you wish${nc}"
        echo -e "${msg} to enable the ports tree in. Finally, click '${inf}Save${msg}'.${nc}"
        echo -e "${msg} Optionally you may also tick the '${inf}Cronjob${msg}' box and click '${inf}Save${msg}'.${nc}"
        echo -e "${msg} This won't automatically apply the updates but it will make it so in future,${nc}"
        echo -e "${msg} You may come back to this page and simply click '${inf}Update${msg}'${nc}"
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

thebrig.howto.enableportstree

#------------------------------------------------------------------------------#
### THEBRIG - HOW-TO: INSTALL THEBRIG
#------------------------------------------------------------------------------#

thebrig.howto.installthebrig ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} TheBrig - How to install TheBrig manually${nc}"
        echo -e "${sep}"
        echo " "
        # Create directory
        # mkdir -p ${thebriginstalldir}
        # change to directory
        # cd ${thebriginstalldir}
        # Fetch TheBrig installer
        # fetch https://raw.githubusercontent.com/fsbruva/thebrig/alcatraz/thebrig_install.sh
        # Execute the script
        # /bin/sh thebrig_install.sh ${thebriginstalldir} &

        # echo " 1: Go to Extensions page in WebGUI > TheBrig > Maintenance > Rudimentary Config (Should take you to this config by default)"
        # echo " 2: Click 'Save' (Make sure 'Installation folder' is correct first,"
        # echo "    we want it outside of the NAS4Free operating system drive"
        # echo " 3: Head to Tarball Management (Underneath 'Maintenance') > Clicked Query!"
        # echo " 4: Chose 'Release: 10.2-RELEASE' from dropdown menu (Should be selected by     default after clicking query)"
        # echo " 5: Tick all boxes below (Only 'base.txz' and 'lib32.txz' are really needed but grab all anyway)"
        # echo " 6: Click Fetch, wait a while for the downloads to finish"
        # echo " Once all the download bars are gone you can proceed to making your jail"
        # echo " Instructions on creating a jail can be found in the 'more info' menu"
        echo -e "${emp} This part of the script is unfinished currently :(${nc}"
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

thebrig.howto.installthebrig

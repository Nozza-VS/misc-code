#------------------------------------------------------------------------------#
### THEBRIG - HOW-TO: MOUNT YOUR STORAGE IN JAIL WITH FSTAB
#------------------------------------------------------------------------------#

thebrig.howto.mountviafstab ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} TheBrig - How to mount any storage folder in a jail using fstab${nc}"
        echo -e "${sep}"
        echo " "
        echo -e "${msg} First, you need to create a folder in the jail matching the name of the folder to mount${nc}"
        echo -e "${msg} Example: mkdir /mnt/Storage/Jails/JailName/mnt/MEDIA${nc}"
        echo -e "${msg} Now, head to your NAS webgui and go to '${inf}Extensions${msg}' -> '${inf}TheBrig.${nc}"
        echo -e "${msg} Click the settings icon for the jail you wish to have your folder mounted in.${nc}"
        echo -e "${msg} Now click the '${inf}More${msg}' button near the bottom.${nc}"
        echo -e "${msg} You should be presented with a lot more options.${nc}"
        echo -e "${msg} Look for '${inf}Fstab for current jail${msg}'${nc}"
        echo -e "${msg} An example of what to set in here is:${nc}"
        echo -e "${msg} /mnt/Storage/Media /mnt/Jails/JailName/mnt/MEDIA nullfs rw 0 0${nc}"
        echo -e "${msg} /mnt/Storage/Media = The folder you want mounted${nc}"
        echo -e "${msg} /mnt/Jails/JailName/mnt/MEDIA = The jail folder to mount in${nc}"
        echo -e "${msg} 'rw 0 0' at the end = the jail may write to the folder${nc}"
        echo -e "${msg} 'ro 0 0' at the end = the jail may NOT write to the folder${nc}"
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

thebrig.howto.mountviafstab

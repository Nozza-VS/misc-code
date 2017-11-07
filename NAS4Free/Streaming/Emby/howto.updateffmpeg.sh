#------------------------------------------------------------------------------#
### EMBY SERVER - HOW-TO: UPDATE FFMPEG FROM PORTS TREE (FOR TRANSCODING)
#------------------------------------------------------------------------------#

emby.howto.updateffmpeg ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} Emby - How to update FFMpeg from ports tree:"
        echo -e "${sep}"
        echo " "
        echo -e "${msg} Remove default FFMpeg package:${nc}"
        echo -e "${cmd}    pkg delete -f ffmpeg${nc}"
        echo -e "${msg} Reinstall FFMpeg from ports with 'lame' & 'ass' options${nc}"
        echo -e "${msg} enabled. To enable an option, highlight it using the arrow${nc}"
        echo -e "${msg} keys and press space (I also enable 'OPUS' option)${nc}"
        echo -e "${cmd}    cd /usr/ports/multimedia/ffmpeg${nc}"
        echo -e "${cmd}    make config${nc}"
        echo -e "${msg} This final step will take some time and you will also${nc}"
        echo -e "${msg} get a few prompts, just press enter each time.${nc}"
        echo -e "${cmd}    make install clean${nc}"
        echo -e "${msg} Once it is done, restart the emby server${nc}"
        echo -e "${cmd}    service emby-server restart${nc}"
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

emby.howto.updateffmpeg

#------------------------------------------------------------------------------#
### EMBY - RECOMPILE FROM PORTS
#------------------------------------------------------------------------------#

recompile.ffmpeg ()
{

recompile.ffmpeg.continue ()
{
echo -e "${msep}"
echo -e "${emp}   Press Enter To Continue${nc}"
echo -e "${msep}"
read -r -p " " response
case "$response" in
    *)
              # Otherwise continue with backup...
              ;;
esac
}

# Confirm with the user
echo -e "${msg} These steps could take some time${nc}"
read -r -p "   Would you like to recompile these now? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              echo " "
              echo -e "${sep}"
              echo -e "${fin} Great, now ffmpeg${nc}"
              echo -e "${sep}"
              echo " "

              cd /usr/ports/multimedia/ffmpeg && make deinstall

              echo " "
              echo -e "${sep}"
              echo -e "${msg} When the options pop up, enable (By pressing space when its highlighted):${nc}"
              echo -e "${inf}    ASS     ${msg}(required for subtitle rendering)${nc}"
              echo -e "${inf}    LAME    ${msg}(required for mp3 audio transcoding -${nc}"
              echo -e "${inf}            ${msg}disabled by default due to mp3 licensing restrictions)${nc}"
              echo -e "${inf}    OPUS    ${msg}(required for opus audio codec support)${nc}"
              echo -e "${inf}    X265    ${msg}(required for H.265 video codec support${nc}"
              echo -e "${msg} Then press 'OK' for every box that follows.${nc}"
              echo -e "${msg} This one may take a while, please be patient${nc}"
              echo -e "${sep}"
              echo " "

              recompile.ffmpeg.continue

              make clean
              make clean-depends
              make config

              echo " "
              echo -e "${sep}"
              echo -e "${msg} Press 'OK'/'Enter' for any box that follows.${nc}"
              echo -e "${sep}"
              echo " "

              recompile.ffmpeg.continue

              #make install clean
              make -DBATCH install clean

              echo " "
              echo -e "${sep}"
              echo -e "${msg} Finished with the recompiling!${nc}"
              echo -e "${sep}"
              echo " "
              ;;
esac
}

recompile.ffmpeg

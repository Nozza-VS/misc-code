recompile.from.ports ()
{
# Confirm with the user
echo -e "${msg} These steps could take some time and are NOT required.${nc}"
echo -e "${msg} If you're unsure what 'ports' are or if you have them, choose 'No'.${nc}"
read -r -p "   Would you like to recompile these now? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then make a backup before proceeding
              echo " "
              echo -e "${sep}"
              echo -e "${fin} First, lets do ImageMagick${nc}"
              echo -e "${msg} When the options pop up, disable (By pressing space when its highlighted):${nc}"
              echo -e "${inf}    16BIT_PIXEL   ${msg}(to increase thumbnail generation performance)${nc}"
              echo -e "${msg} and then press 'Enter'${nc}"
              echo " "

              update.emby.continue

              cd /usr/ports/graphics/ImageMagick && make deinstall
              make clean && make clean-depends
              make config

              echo " "
              echo -e "${sep}"
              echo -e "${msg} Press 'OK'/'Enter' if any box that follows.${nc}"
              echo -e "${msg}    (There shouldn't be any that pop up)${nc}"
              echo -e "${sep}"
              echo " "

              update.emby.continue

              #make install clean
              make -DBATCH install clean

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
              echo -e "${msg} Then press 'OK' for any box that follows.${nc}"
              echo -e "${msg} This one may take a while, please be patient${nc}"
              echo -e "${sep}"
              echo " "

              update.emby.continue

              make clean
              make clean-depends
              make config

              echo " "
              echo -e "${sep}"
              echo -e "${msg} Press 'OK'/'Enter' for any box that follows.${nc}"
              echo -e "${sep}"
              echo " "

              update.emby.continue

              #make install clean
              make -DBATCH install clean

              echo " "
              echo -e "${sep}"
              echo -e "${msg} Finished with the recompiling!${nc}"
              echo -e "${sep}"
              echo " "

			  # Prevent package manager from updating this
			  #pkg lock ImageMagick
			  #pkg lock ffmpeg

              ;;
    *)
              # Otherwise continue with update...
              echo " "
              echo -e "${inf} Skipping for now.. (You can do this later via the Emby menu)${nc}"
              ;;
esac
}

recompile.from.ports

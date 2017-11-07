#------------------------------------------------------------------------------#
### EMBY - RECOMPILE FROM PORTS
#------------------------------------------------------------------------------#

recompile.imagemagick ()
{

recompile.imagemagick.continue ()
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
              echo -e "${fin} First, lets do ImageMagick${nc}"
              echo -e "${msg} When the options pop up, disable (By pressing space when its highlighted):${nc}"
              echo -e "${inf}    16BIT_PIXEL   ${msg}(to increase thumbnail generation performance)${nc}"
              echo -e "${msg} and then press 'Enter'${nc}"
              echo " "

              recompile.imagemagick.continue

              cd /usr/ports/graphics/ImageMagick && make deinstall
              make clean && make clean-depends
              make config

              echo " "
              echo -e "${sep}"
              echo -e "${msg} Press 'OK'/'Enter' if any box that follows.${nc}"
              echo -e "${msg}    (There shouldn't be any that pop up)${nc}"
              echo -e "${sep}"
              echo " "

              recompile.imagemagick.continue

              make install clean
              #make -DBATCH install clean

              echo " "
              echo -e "${sep}"
              echo -e "${msg} Finished with the recompiling!${nc}"
              echo -e "${sep}"
              echo " "
              ;;
esac
}

recompile.imagemagick

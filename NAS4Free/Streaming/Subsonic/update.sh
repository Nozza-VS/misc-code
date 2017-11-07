#------------------------------------------------------------------------------#
### SUBSONIC CONFIRM UPDATE

confirm.update.subsonic ()
{
# Confirm with the user
read -r -p "   Confirm Update of Subsonic? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.subsonic
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### SUBSONIC UPDATE

update.subsonic ()
{
echo -e "${emp} This part of the script is unfinished currently :(${nc}"
echo " "

pkg update
pkg upgrade

}

confirm.update.subsonic

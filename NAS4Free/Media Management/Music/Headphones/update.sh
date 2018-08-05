#------------------------------------------------------------------------------#
### HEADPHONES CONFIRM UPDATE

confirm.update.headphones ()
{
# Confirm with the user
read -r -p "   Confirm Update of Headphones? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.headphones
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### HEADPHONES UPDATE

update.headphones ()
{
echo -e "${emp} This part of the script is unfinished currently :(${nc}"
# Headphones can be updated automatically
# TODO: Add instructions on how to enable auto updates
# TODO: Add manual update here just in case (via github)
echo " "

pkg update
pkg upgrade

}

confirm.update.headphones
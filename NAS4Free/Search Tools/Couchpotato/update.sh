#------------------------------------------------------------------------------#
### COUCHPOTATO CONFIRM UPDATE

confirm.update.couchpotato ()
{
# Confirm with the user
read -r -p "   Confirm Update of CouchPotato? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.couchpotato
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### COUCHPOTATO UPDATE

update.couchpotato ()
{
echo -e "${emp} This part of the script is unfinished currently :(${nc}"
# CouchPotato can be updated automatically
# TODO: Add instructions on how to enable auto updates
# TODO: Add manual update here just in case (via github)
echo " "

pkg update
pkg upgrade

}

confirm.update.couchpotato
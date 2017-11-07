#------------------------------------------------------------------------------#
### VENTRILO SERVER CONFIRM INSTALL

confirm.install.ventrilo ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Ventrilo? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.ventrilo
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### VENTRILO SERVER INSTALL

install.ventrilo ()
{

#Update the pkg management system first
pkg update
pkg upgrade

}

confirm.install.ventrilo

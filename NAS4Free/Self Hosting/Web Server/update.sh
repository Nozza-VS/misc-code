#------------------------------------------------------------------------------#
### WEB SERVER CONFIRM UPDATE

confirm.update.webserver ()
{
# Confirm with the user
read -r -p "   Confirm Update of Web Server? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.webserver
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}



confirm.update.webserver
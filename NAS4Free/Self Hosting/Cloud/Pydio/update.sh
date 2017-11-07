#------------------------------------------------------------------------------#
### PYDIO CONFIRM UPDATE

confirm.update.pydio ()
{
# Confirm with the user
read -r -p "   Confirm Update of Pydio? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.pydio
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### PYDIO UPDATE

update.pydio ()
{
	echo " "
}

confirm.update.pydio
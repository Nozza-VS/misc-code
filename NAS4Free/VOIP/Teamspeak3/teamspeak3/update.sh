#------------------------------------------------------------------------------#
### TEAMSPEAK 3 SERVER CONFIRM UPDATE

confirm.update.teamspeak3 ()
{
# Confirm with the user
read -r -p "   Confirm Update of Teamspeak 3 Server? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.teamspeak3
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}



#------------------------------------------------------------------------------#
### TEAMSPEAK 3 SERVER UPDATE

update.teamspeak3 ()
{

echo -e "${emp} This part of the script is unfinished currently :(${nc}"
echo " "

pkg update
pkg upgrade nzbget

}

confirm.update.teamspeak3

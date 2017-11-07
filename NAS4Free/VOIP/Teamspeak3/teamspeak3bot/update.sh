#------------------------------------------------------------------------------#
### TEAMSPEAK 3 SERVER BOT CONFIRM UPDATE

confirm.update.teamspeak3bot ()
{
# Confirm with the user
read -r -p "   Confirm Update of Teamspeak 3 Server Bot? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.teamspeak3bot
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}



#------------------------------------------------------------------------------#
### TEAMSPEAK 3 SERVER BOT UPDATE

update.teamspeak3bot ()
{

echo -e "${emp} This part of the script is unfinished currently :(${nc}"
echo " "

pkg update
pkg upgrade nzbget

}

confirm.update.teamspeak3bot

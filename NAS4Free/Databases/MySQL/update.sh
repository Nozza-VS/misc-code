### MYSQL CONFIRM UPDATE
#------------------------------------------------------------------------------#

confirm.update.mysql ()
{
# Confirm with the user
read -r -p "   Confirm Update of MySQL? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.mysql
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### MYSQL UPDATE

update.mysql ()
{
echo -e "${emp} This part of the script isn't entirely finished but should${nc}"
echo -e "${emp} still work as intended.${nc}"
echo " "

service apache24 stop
/usr/local/etc/rc.d/mysql-server stop

pkg update
pkg upgrade mysql56-server mod_php56 php56-mysql php56-mysqli phpmyadmin apache24

/usr/local/etc/rc.d/mysql-server start
service apache24 start

}

confirm.update.mysql

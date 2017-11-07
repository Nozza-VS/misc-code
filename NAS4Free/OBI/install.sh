#------------------------------------------------------------------------------#
### OBI CONFIRM INSTALL

confirm.install.obi ()
{
# Confirm with the user
echo -e "${emp} WARNING: THIS HAS BEEN UNTESTED${nc}"
echo -e "${emp} USE AT YOUR OWN RISK${nc}"
echo -e "${emp} DO NOT INSTALL INSIDE A JAIL, RUN ON HOST SYSTEM${nc}"
echo " "
read -r -p "   Confirm Installation of OneButtonInstaller? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.obi
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### OBI INSTALL

install.obi ()
{


echo " "
echo -e "${sep}"
echo -e "${msg}   Welcome to OneButtonInstaller... installer!${nc}"
echo -e "${sep}"
echo " "

echo " "

echo " "
echo -e "${sep}"
echo -e "${msg} Let's get on with the install.${nc}"
echo -e "${sep}"
echo " "

fetch https://raw.github.com/crestAT/nas4free-onebuttoninstaller/master/OBI.php && mkdir -p ext/OBI && echo '<a href="OBI.php">OneButtonInstaller</a>' > ext/OBI/menu.inc && echo -e "\nDONE"

echo " "
echo -e "${sep}"
echo -e "${msg} OBI should now be successfully installed${nc}"
echo -e "${msg} Head to your NAS4Free WebGUI and you should find it under${nc}"
echo -e "${msg}    EXTENSIONS | OneButtonInstaller${nc}"
echo -e "${msg} On this page choose where to install it to and hit 'Save'.${nc}"
echo -e "${msg} Now your done and ready to easily install things such as TheBrig!${nc}"
echo -e "${sep}"
echo " "
}

confirm.install.obi

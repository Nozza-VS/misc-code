#------------------------------------------------------------------------------#
### THEBRIG EXPERIMENTAL INSTALL

install.thebrig.EXPERIMENTAL ()
{
confirmstorage ()
{
# Confirm with the user
read -r -p "   Correct path? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              echo -e "${url} Great! We'll install thebrig in '${mystorage}/Jails'.${nc}"
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo -e "${alt} This needs to be correct.${nc}"
              echo -e "${alt} Please modify the 'mystorage' at the start of${nc}"
              echo -e "${alt} the script before running this again.${nc}"
              echo " "
              exit
              ;;
esac
}

confirmsuccess ()
{
# Confirm with the user
echo -e "${msg} Head to your NAS WebGUI - Refresh page if it's already open${nc}"
read -r -p "   Can you seen an 'Extensions' tab with 'TheBrig' listed? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              echo -e "${url} Good! Now follow the How-To for finalizing the setup.${nc}"
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo -e "${alt} Seems this script had an issue somewhere ${nc}"
              echo " "
              exit
              ;;
esac
}

echo " "
echo -e "${sep}"
echo -e "${msg}   Welcome to theBrig installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   This should hopefully install TheBrig for you without any problems!${nc}"
echo " "
echo -e "${msg} Let's start with double checking your storage path.${nc}"
echo -e "${msg} Is this the correct path to your mounted storage?${nc}."
echo -e "${qry} ${mystorage} ${nc}."
echo -e "${sep}"
echo -e " "

confirmstorage

echo " "
echo -e "${sep}"
echo -e "${msg} Let's get on with the install.${nc}"
echo -e "${sep}"
echo " "

# Make folder for TheBrig and it's jails to live in
mkdir ${mystorage}/Jails

# Head to the directory we just made
cd ${mystorage}/Jails

# Download the installer
fetch https://raw.githubusercontent.com/fsbruva/thebrig/alcatraz/thebrig_install.sh

# Run the installer
/bin/sh thebrig_install.sh ${mystorage}/Jails

echo " "
echo -e "${sep}"
echo -e "${msg} TheBrig should now be successfully installed${nc}"
echo -e "${sep}"
echo " "

# Confirm with user
confirmsuccess

}

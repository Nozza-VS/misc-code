#!/bin/sh
# Script Version: 1.0 (March 13, 2016)

# DO NOT USE! THIS IS STILL VERY MUCH UNFINISHED AND MOST DEFINITELY UNTESTED!
# TODO: Test Script
# TODO: Make necessary changes as needed.

###########################################################################
#     This is a script to help assist the installation of TheBrig.
#
#     Made by Nostalgist92/Nozza.
#     Use carefully, I am not responsible for any loss of data.
###########################################################################
# This is NOT a FULLY automated script, you WILL have to do some things
# to get everything set up successfully
# Be sure to read carefully!
###########################################################################

# Modify this to reflect where you have your hard drive mounted
mystorage='/mnt/Storage'



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
              echo -e "${alt} Please modify the 'mystorage' at the start of the script${nc}"
              echo -e "${alt} before running this again.${nc}"
              echo " "
              exit
              ;;
esac
}

confirminstall ()
{
# Confirm with the user
echo -e "${msg} Head to your NAS WebGUI (Refresh the page if you already have it open)${nc}"
read -r -p "   Can you seen an 'Extensions' tab with 'TheBrig' listed? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              echo -e "${url} Good! Now let's finish setting it up.${nc}"
               ;;
    *)
              # Otherwise exit...
              echo " "
              echo -e "${alt} Seems this script had an issue somewhere then :(${nc}"
              echo " "
              exit
              ;;
esac
}

# Add some colour!
nc='\033[0m'        # No Color
alt='\033[0;31m'    # Alert Text
emp='\033[1;31m'    # Emphasis Text
msg='\033[1;37m'    # Message Text
url='\033[1;32m'    # URL
qry='\033[0;36m'    # Query Text
sep='\033[1;30m-------------------------------------------------------\033[0m'    # Line Seperator
cmd='\033[1;35m'    # Command to be entered
fin='\033[0;32m'    # Green Text
inf='\033[0;33m'    # Information Text



echo " "
echo -e "${sep}"
echo -e "${msg}   Welcome to theBrig guided installer!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Hopefully this script will succesfully guide you through${nc}"
echo -e "${msg}   the process of installing TheBrig and setting up your${nc}"
echo -e "${msg}   first jail without any problems!${nc}"
echo " "
echo -e "${msg} Let's start with double checking your storage path.${nc}"
echo -e "${msg} Is this the correct path to your mounted storage?${nc}."
echo -e "${msg} ${mystorage} ${nc}."
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
echo -e "${msg} TheBrig should now be succesfully installed${nc}"
echo -e "${sep}"
echo " "

# Confirm with user
confirminstall

echo " "
echo -e "${sep}"
echo -e " Almost done, just a few more things you need to do"
echo -e " Please read carefully to finish the setup."
echo -e "${sep}"
echo " "

# Now guide through the rest of the setup
echo -e "${msg} Head to that new Extensions->TheBrig page in your WebGUI${nc}"
echo -e "${msg} After making sure the 'Installation folder' = ${mystorage}/Jails, Click 'Save'${nc}"
echo -e "${msg} Now head to 'Tarball Management' (Underneath 'Maintenance') > Click Query!${nc}"
echo -e "${msg} It should now have '10.2-RELEASE in the new dropdown menu (Select it if it isn't already)${nc}"
echo -e "${msg} Tick all boxes below that ${nc}"
echo -e "${msg}    (Only 'base.txz' and 'lib32.txz' are really needed but let's grab them all just in case)${nc}"
echo -e "${msg} Click Fetch, wait some time for the downloads to finish${nc}"
echo -e "${msg} Once all the download bars are gone you can proceed to making your jail${nc}"
echo -e " "

continue

echo " "
echo -e "${sep}"
echo -e " Now we will set up your first jail!"
echo -e " Again, Please read carefully."
echo -e "${sep}"
echo " "

# Finally, guide user through setting up their first jail.
echo -e "${msg} So now we should have everything downloaded and ready to go!${nc}"
echo -e "${msg} Go ahead and click on the 'Jails' tab${nc}"
echo -e "${msg} You should see a '+' sign on this page, click on that to create a new jail${nc}"
echo -e "${msg} Most things can be left as default. The things you have to change are:${nc}"
echo -e "${msg}    'Jail Network Settings', 'Official FreeBSD Flavor'${nc}"
echo " "
echo -e "${msg} Optional things to change are:${nc}"
echo -e "${msg}    'Jail name', 'Start on boot', 'Description'${nc}"
echo " "
echo -e "${msg} Things best left alone unless you know what you are doing:${nc}"
echo -e "${msg}    'Jail start command', 'User command stop' & anything in the 'More' section.${nc}"
echo " "
echo -e "${msg} The absolute most important is the 'Jail Network settings'${nc}"
echo -e "${msg}    On the right, make sure your network device is selected.${nc}"
echo -e "${msg}    Next to that, type an IP Adress for the jail.${nc}"
echo -e "${msg}    It can NOT BE THE SAME as any other device on your network.${nc}"
echo -e "${msg}    It's best to use a high range such as 192.168.1.200 < VARIES DEPENDING ON YOUR NETWORK!${nc}"

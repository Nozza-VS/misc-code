#!/bin/sh
# Version 2.1.0 (March 17, 2016)

################################################################################
##### CONFIRMATIONS
# TODO: Add confirms for all installs as a safety thing
################################################################################
### INSTALL CONFIRMATIONS

confirminstallpackagemethod ()
{
# Give user information about what will happen
}

confirminstallalternativemethod ()
{
# Give user information about what will happen
}

### UPDATE CONFIRMATIONS
# TODO: Add run backup before update commands + inform the user of backup

confirmupdatepackagemethod ()
{
# Give user information about what will happen
}

confirmupdatealternativemethod ()
{
# Give user information about what will happen
}



################################################################################
##### INSTALLERS
# TODO: Finish the rest of the installers
################################################################################

installpackagemethod ()
{
# Run the install
}

installalternativemethod ()
{
# Run the install
}

################################################################################
##### UPDATERS
# TODO: Start working on all applicable updaters
################################################################################

updatepackagemethod ()
{
# Run the update after creating a backup
}

updatealternativemethod ()
{
# Run the update after creating a backup
}

################################################################################
##### BACKUPS
# TODO: Start working on all applicable backups
################################################################################

backuppackagemethod ()
{
# Run the backup
# Give user information about where backups are stored and how to restore them
}

backupalternativemethod ()
{
# Run the backup
# Give user information about where backups are stored and how to restore them
}

################################################################################
##### SUBMENUS 
# TODO: Add appropriate commands to backups option once finished
################################################################################

installsonarrsubmenu ()
{
while [ "$choice" != "q" ]
do
        echo -e "${fin} Install Sonarr - Options${nc}"
        echo
        echo -e "${qry} Choose one:"
        echo -e "${fin}   1)${msg} Install via Packages (Preferred)"
        echo -e "${fin}   2)${msg} Install via Github"
        echo -e "${emp}   3) Main Menu${nc}"
        echo

        read choice

        case $choice in
            '1') echo -e "${inf} Installing..${nc}"
                confirminstallpackagemethod
                ;;
            '2') echo -e "${inf} Running Update..${nc}"
                confirminstallalternativemethod
                ;;
            '3') return
                ;;
        esac
done
}

updatesonarrsubmenu ()
{

}

backupsonarrsubmenu ()
{

}

################################################################################
##### MAIN MENU
################################################################################

mainmenu=""

while [ "$choice" != "q,i" ]
do
        echo -e "${sep}"
        echo -e "${inf} Script Version: 2.1.0 (March 17, 2016)"
        echo " "
        echo -e "${msg} Main Menu"
        echo " "
        echo -e "${qry} Please make a selection!"
        echo " "
        echo -e "${fin}   1)${msg} Install Sonarr${nc}"
        echo -e "${fin}   2)${msg} Update Sonarr${nc}"
        echo -e "${fin}   3)${msg} Backup Sonarr${nc}"
        echo " "
        echo -e "${alt}  q) Quit${nc}"
        echo -e "${sep}"

        read choice

        case $choice in
            '1') 
                installsonarrsubmenu
                ;;
            '2') 
                updatesonarrsubmenu
                ;;
            '3') 
                backupsonarrsubmenu
                ;;
            'q') echo -e "${alt}        Exiting script!${nc}"
                echo " "
                ;;
            *)   echo -e "${emp}        Invalid choice, please try again${nc}"
                ;;
        esac
done
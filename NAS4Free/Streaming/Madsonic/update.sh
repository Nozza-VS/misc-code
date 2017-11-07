#------------------------------------------------------------------------------#
### MADSONIC CONFIRM UPDATE

confirm.update.madsonic ()
{
# Confirm with the user
read -r -p "   Confirm Update of Madsonic? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.madsonic
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}

#------------------------------------------------------------------------------#
### MADSONIC UPDATE

update.madsonic ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Welcome to the Madsonic updater!${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's get started with some questions${nc}"
echo -e "${sep}"
echo " "
read -r -p " Double check your version, is it the latest? [y/N] " response
    case $response in
        [yY][eE][sS]|[yY])
            echo " No need to update anything then${nc}"
            ;;
        *)
            echo " "
            echo -e "${sep}"
            echo -e "${msg} Paste the download link to the madsonic standalone package${nc}"
            echo -e "${qry} Example link:"
            echo -e "${url} http://madsonic.org/download/6.2/20161222_madsonic-6.2.9080-war-jspc.zip${nc}"
            echo " "
            echo "Link:"
            read madlink
            echo " "
            echo -e "${msg} Which version number is it?${nc}"
            echo -e "${qry} Example version:${nc}"
            echo -e "${url} 6.2.9080${nc}"
            echo " "
            echo "Version:"
            read madversion
            echo " "
            echo -e "${sep}"
            echo -e "${msg} Downloading update${nc}"
            echo -e "${sep}"
            echo " "

            #fetch -o madsonic"$buildno".tar.gz "$madlink"
            fetch -o /tmp/madsonic-"$madversion".zip "$madlink"
            #tar xvzf madsonic"$buildno".tar.gz -C /usr/local/share/madsonic-standalone
            echo " Download finished"

            echo " "
            echo -e "${sep}"
            echo -e "${msg} Stopping madsonic service to apply update${nc}"
            echo -e "${sep}"
            echo " "

            service madsonic stop

            echo " "
            echo -e "${sep}"
            echo -e "${msg} Extracting downloaded file${nc}"
            echo -e "${sep}"
            echo " "

            unzip -o /tmp/madsonic-"$madversion".zip -d /usr/local/share/madsonic-standalone
            chmod +x /usr/local/share/madsonic-standalone/*
            echo " Extraction finished"

            echo " "
            echo -e "${sep}"
            echo -e "${msg} Starting madsonic service${nc}"
            echo -e "${sep}"
            echo " "
            service madsonic start
            ;;
    esac
}

confirm.update.madsonic

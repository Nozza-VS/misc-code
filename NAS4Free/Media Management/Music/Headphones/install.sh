#------------------------------------------------------------------------------#
### HEADPHONES CONFIRM INSTALL

confirm.install.headphones ()
{
# Confirm with the user
read -r -p "   Confirm Installation of Headphones? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              install.headphones
               ;;
    *)
              # Otherwise exit...
              echo " "
              return
              ;;
esac
}



#------------------------------------------------------------------------------#
### HEADPHONES INSTALL

install.headphones ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Headphones Installer${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg}   Let's install required packages first${nc}"
echo -e "${sep}"
echo " "

pkg install python py27-sqlite3 fpc-libcurl docbook-xml git-lite ffmpeg flac lame

echo " "
echo -e "${sep}"
echo -e "${msg} Grab Headphones from github${nc}"
echo -e "${msg} Headphones will be installed to:${nc}"
echo -e "${inf}    /usr/local/Headphones${nc}"
echo -e "${sep}"
echo " "

git clone https://github.com/rembo10/headphones.git /usr/local/Headphones

echo " "
echo -e "${sep}"
echo -e "${msg} Fetch Headphones startup script from github${nc}"
echo -e "${sep}"
echo " "

# cp headphones/init-scripts/init.freebsd /usr/local/etc/rc.d/headphones
#Fetch Nostalgist92's startup script instead
fetch --no-verify-peer -o /usr/local/etc/rc.d/headphones "https://raw.githubusercontent.com/Nostalgist92/misc-code/master/NAS4Free/HeadPhones/init-script"
#Make startup script executable
chmod 555 /usr/local/etc/rc.d/headphones
chmod +x /usr/local/etc/rc.d/headphones
# Potentially need to modify the line:
#command_args = "- f -p $ {python headphones_pid} $ {} headphones_dir /Headphones.py $ {} headphones_flags --quiet --nolaunch"
# To:
#command_args = "- f -p $ {} headphones_pid python2.7 $ {} headphones_dir /Headphones.py $ {} headphones_flags --quiet --nolaunch"
# Further testing needed, will update my init script if deemed necessary.

echo " "
echo -e "${sep}"
echo -e "${msg} Enable automatic startup at boot for Headphones${nc}"
echo -e "${sep}"
echo " "

echo 'headphones_enable="YES"' >> /etc/rc.conf

echo " "
echo -e "${sep}"
echo -e "${msg} Start Headphones${nc}"
echo -e "${sep}"
echo " "

service headphones start

#
echo " "
echo -e "${sep}"
echo -e "${msg} Open your browser and go to: ${url}jailip:8181${nc}"
echo -e "${sep}"
echo " "

echo " "
echo -e "${sep}"
echo -e "${msg} Done here!${nc}"
echo -e "${msg} Feel free to visit the project homepage at:${nc}"
#echo -e "${url}    https://gitlab.com/sarakha63/headphones${nc}"
echo -e "${url}    https://github.com/rembo10/headphones${nc}"
echo -e "${sep}"
echo " "
}

confirm.install.headphones
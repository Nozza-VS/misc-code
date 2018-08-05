#!/bin/sh

lidarr_def_ver="0.2.0.295"
lidarr_dl_url="https://ci.appveyor.com/project/Lidarr/lidarr/branch/develop/artifacts"
#------------------------------------------------------------------------------#
#Grab the date & time to be used later
date=$(date +"%Y.%m.%d-%I.%M%p")
#------------------------------------------------------------------------------#
# Add some colour!
nc='\033[0m'        # Default Text (No Formatting / No Color)
alt='\033[0;31m'    # Alert Text
emp='\033[1;31m'    # Emphasis Text
msg='\033[1;37m'    # Message Text
url='\033[1;32m'    # URL
qry='\033[0;36m'    # Query Text
ssep='\033[1;30m#----------------------#\033[0m'    # Small Line Separator
msep='\033[1;30m#--------------------------------------#\033[0m'    # Medium Line Separator
sep='\033[1;30m----------------------------------------------------------------------\033[0m'   # Line Separator
cmd='\033[1;35m'    # Command to be entered
fin='\033[0;32m'    # Green Text
inf='\033[0;33m'    # Information Text
ul='\033[4m'        # Underline Text
lbt='\033[1;34m'    # Light Blue Text
yt='\033[1;33m'     # Yellow Text
lct='\033[1;36m'    # Light Cyan Text
ca='\033[1;30m'     # Currently Unavailable (Dark Grey Text)
#------------------------------------------------------------------------------#
### LIDARR CONFIRM UPDATE

confirm.update.lidarr ()
{
echo " "
echo -e "${sep}"
echo -e "${msg}   Lidarr Updater${nc}"
echo -e "${sep}"
echo " "
echo -e "${emp} CAUTION: Things can go wrong! I highly suggest${nc}"
echo -e "${emp}          having a backup just in case!${nc}"
echo -e "${inf}          (Script will offer to create one)${nc}"
echo " "
echo -e "${msg} Only continue if you are 100% sure${nc}"
# Confirm with the user
read -r -p "   Confirm Update of Lidarr? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.lidarr
               ;;
    *)
              # Otherwise exit...
              echo " "
			  echo -e "${alt}   Update cancelled${nc}"
			  echo " "
              return
              ;;
esac
echo " "
echo " "
}

#------------------------------------------------------------------------------#
### LIDARR UPDATE

update.lidarr ()
{

update.lidarr.continue ()
{
echo -e "${msep}"
echo -e "${emp}   Press Enter To Continue${nc}"
echo -e "${msep}"
read -r -p " " response
case "$response" in
    *)
              ;;
esac
}

select.lidarr.update.version ()
{
echo -e "${msg} You can let the script install the default version (${qry}${lidarr_def_ver}${msg})${nc}"
echo -e "${msg} Or you can select the version to install yourself.${nc}"
echo -e "${emp} Only do so if you know what you're doing!${nc}"
echo " "
read -r -p " Select version yourself? [y/N] " response
    case $response in
        [yY][eE][sS]|[yY])
            echo " "
            echo -e "${msg} You can find release numbers here:${nc}"
            echo -e "${url} ${lidarr_dl_url}${nc}"
            echo " "
            echo -e "${msg} Right click the linux.tar.gz and copy link address${nc}"
            echo -e "${qry} Example version:${nc}"
            echo -e "${url} 3.2.36.0${nc}"
            echo " "
			printf "${emp} URL: ${nc}" ; read lidarr_update_url
			echo -e "${fin}    URL set to: ${msg}${lidarr_update_url}${nc}"
			echo " "
			printf "${emp} Version: ${nc}" ; read lidarr_update_version
			echo -e "${fin}    Version set to: ${msg}${lidarr_update_version}${nc}"
			echo " "
            echo -e "${sep}"
            echo -e "${msg} Download the update using defined url${nc}"
            echo -e "${sep}"
            echo " "
            fetch --no-verify-peer -o /tmp/Lidarr.develop.${lidarr_update_version}.linux.tar.gz $lidarr_update_url
            echo " "
            echo -e "${sep}"
            echo -e "${msg} Download done, let's stop the server${nc}"
            echo -e "${sep}"
            echo " "

            service lidarr stop
			mv /usr/local/share/lidarr /usr/local/share/lidarr.${date}

            echo " "
            echo -e "${sep}"
            echo -e "${msg} Now to extract the download and replace old version${nc}"
            echo -e "${sep}"
            echo " "

			#if [ -f "/tmp/emby-${userselected_emby_update_ver}.zip" ]
			#then
			#	echo "$userselected_emby_update_ver.zip found, extracting"
			#    unzip -o "/tmp/emby-${userselected_emby_update_ver}.zip" -d /usr/local/lib/emby-server
			#else
			#	echo "$userselected_emby_update_ver.zip not found"
			#fi
			
            tar -xvf /tmp/Lidarr.develop.${lidarr_update_version}.linux.tar.gz -C /usr/local/share/
			mv /usr/local/share/Lidarr /usr/local/share/lidarr			
            ;;
        *)
            echo " "
            echo " Using default version as defined by script (${lidarr_def_ver})"
            echo " "
            echo -e "${sep}"
            echo -e "${msg} Grab the update for Emby from github${nc}"
            echo -e "${sep}"
            echo " "

			wget -O /tmp/Lidarr.develop.${lidarr_def_ver}.linux.tar.gz https://ci.appveyor.com/api/buildjobs/w3mqu9a4gtrdgv38/artifacts/Lidarr.develop.${lidarr_def_ver}.linux.tar.gz
            echo " "
            echo -e "${sep}"
            echo -e "${msg} Download done, let's stop the server${nc}"
            echo -e "${sep}"
            echo " "

            service emby-server stop

            echo " "
            echo -e "${sep}"
            echo -e "${msg} Now to extract the download and replace old version${nc}"
            echo -e "${sep}"
            echo " "

            unzip -o "/tmp/emby-${emby_def_update_ver}.zip" -d /usr/local/lib/emby-server
            ;;
    esac
}

select.lidarr.update.version

service lidarr start

remove.downloaded.files

update.lidarr.continue

}

confirm.update.lidarr








# Download
#wget -O /tmp/Lidarr.develop.0.2.0.316.linux.tar.gz https://ci.appveyor.com/api/buildjobs/81431dy59a89xnie/artifacts/Lidarr.develop.0.2.0.316.linux.tar.gz
# Stop service and move app
#service lidarr stop
#mv /usr/local/share/lidarr /usr/local/share/lidarr.old
# Extract
#tar -xvf /tmp/Lidarr.develop.0.2.0.316.linux.tar.gz -C /usr/local/share/
#mv /usr/local/share/Lidarr /usr/local/share/lidarr
# Delete leftovers
#rm /tmp/Lidarr.develop.*.linux.tar.gz
#service lidarr start
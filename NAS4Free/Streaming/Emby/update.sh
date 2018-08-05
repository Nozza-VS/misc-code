#!/bin/sh
#------------------------------------------------------------------------------#

echo " "
echo -e "${sep}"
echo -e "${msg}   Emby Server Updater${nc}"
echo -e "${sep}"
echo " "
echo " Checking currently installed version.."
echo " Checking latest version number on github.."

#------------------------------------------------------------------------------#

INSTALLED_VERSION=$(pkg version -x emby-server | sed -e 's/emby-server-//g' | sed 's/_.*//')
LATEST_RELEASE=$(curl -L -s -H 'Accept: application/json' https://github.com/MediaBrowser/Emby.Releases/releases/latest)
LATEST_VERSION=$(echo $LATEST_RELEASE | sed -e 's/.*"tag_name":"\([^"]*\)".*/\1/')
RELEASE_URL="https://github.com/MediaBrowser/Emby.Releases/releases/download/${LATEST_VERSION}/emby-server-freebsd_${LATEST_VERSION}_amd64.txz"

version_compare() { test "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1"; }

#------------------------------------------------------------------------------#
### EMBY SERVER CONFIRM UPDATE (LATEST GIT METHOD)

confirm.update.emby ()
{
echo " "
echo " Installed: $INSTALLED_VERSION | Latest: $LATEST_VERSION."
#if version_compare $INSTALLED_VERSION $LATEST_VERSION; then
#     echo " No update available"
#else
#	echo " Update available!"
#fi
echo " "
echo -e "${emp} CAUTION: Things can go wrong! I highly suggest${nc}"
echo -e "${emp}          having a backup just in case!${nc}"
echo -e "${inf}          (Script will offer to create one)${nc}"
echo " "
echo -e "${msg} Only continue if you are 100% sure${nc}"
# Confirm with the user
read -r -p "   Confirm Update of Emby Media Server? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then continue
              update.emby
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
### EMBY SERVER UPDATE

update.emby ()
{

update.emby.continue ()
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

remove.old.backups ()
{
read -r -p "   Remove old backups? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then make a backup before proceeding
              rm -r /usr/local/lib/emby-server-backups/*
              rm -r /var/db/emby-server-backups/*
              ;;
    *)
              # Otherwise continue with backup...
              echo " "
              echo -e "${inf} Continuing with backup..${nc}"
              ;;
esac
}

create.emby.backup ()
{
# Confirm with the user
echo -e "${msg} Recommended if you haven't done so already:${nc}"
read -r -p "   Create a backup before updating? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then make a backup before proceeding
              echo " "
              echo -e "${sep}"
              echo -e "${msg}   Would you like to remove any old backups before creating a new one?${nc}"
              echo -e "${msg}   This helps reduce the amount of space used by backups.${nc}"
              echo -e "${sep}"
              echo " "

              remove.old.backups

              echo " "
              echo -e "${sep}"
              echo -e "${msg}   Make sure we have rsync and then use it to create a backup${nc}"
              echo -e "${sep}"
              echo " "

              # Using rsync rather than cp so we can see progress actually happen on the backup for large servers.
              pkg install -y rsync

              # If yes, then create backup
              echo " "
              echo -e "${sep}"
              echo -e "${msg} Running backups${nc}"
              echo -e "${sep}"
              echo " "

              echo -e "${emp} Application backup${nc}"
              mkdir -p /usr/local/lib/emby-server-backups/${date} # Using -p in case you've never run the script before or you have deleted this folder
              rsync -a --info=progress2 /usr/local/lib/emby-server/ /usr/local/lib/emby-server-backups/${date}
              echo -e "${fin}    Application backup done..${nc}"

              echo " "

              echo -e "${emp} Server data backup ${inf}(May take a while, % may not be accurate)${nc}"
              mkdir -p /var/db/emby-server-backups/${date}
              rsync -a --info=progress2 /var/db/emby-server/ /var/db/emby-server-backups/${date}
              echo -e "${fin}    Server backup done.${nc}"
              ;;
    *)
              # Otherwise continue with update...
              echo " "
              echo -e "${inf} Skipping backup..${nc}"
              ;;
esac
}

select.emby.update.version ()
{
echo -e "${msg} You can let the script install the latest version (${qry}${LATEST_VERSION}${msg})${nc}"
echo -e "${msg} Or you can select the version to install yourself.${nc}"
echo -e "${emp} Only do so if you know what you're doing!${nc}"
echo " "
read -r -p " Select version yourself? [y/N] " response
    case $response in
        [yY][eE][sS]|[yY])
            echo " "
            echo -e "${msg} You can find release numbers here:${nc}"
            echo -e "${url} https://github.com/MediaBrowser/Emby.Releases/releases${nc}"
            echo " "
            echo -e "${emp} NOTE: ${inf}If selecting a beta or dev version,${nc}"
            echo -e "${inf} leave off the '-beta'/'-dev' from version number!${nc}"
            echo " "
            echo -e "${msg} Which version number do you want?${nc}"
            echo -e "${qry} Example version:${nc}"
            echo -e "${url} 3.5.1.0${nc}"
            echo " "
			printf "${emp} Version: ${nc}" ; read userselected_emby_update_ver
			echo -e "${fin}    Version set to: ${msg}${userselected_emby_update_ver}${nc}"
			echo " "
            echo -e "${sep}"
            echo -e "${msg} Grab the update for Emby from github${nc}"
            echo -e "${sep}"
            echo " "
            fetch --no-verify-peer -o /tmp/emby-$userselected_emby_update_ver.txz https://github.com/MediaBrowser/Emby.Releases/releases/download/$userselected_emby_update_ver/emby-server-freebsd_${userselected_emby_update_version}_amd64.txz
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

			#if [ -f "/tmp/emby-${userselected_emby_update_ver}.zip" ]
			#then
			#	echo "$userselected_emby_update_ver.zip found, extracting"
			#    unzip -o "/tmp/emby-${userselected_emby_update_ver}.zip" -d /usr/local/lib/emby-server
			#else
			#	echo "$userselected_emby_update_ver.zip not found"
			#fi
            #unzip -o "/tmp/emby-${userselected_emby_update_ver}.zip" -d /usr/local/lib/emby-server
			pkg install -y /tmp/emby-${userselected_emby_update_ver}.txz 
            ;;
        *)
            echo " "
            echo " Using latest version found on github (${LATEST_VERSION})"
            echo " "
            echo -e "${sep}"
            echo -e "${msg} Grab the update for Emby from github${nc}"
            echo -e "${sep}"
            echo " "

            fetch --no-verify-peer -o /tmp/emby-${LATEST_VERSION}.txz ${RELEASE_URL}
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

			#if [ -f "/tmp/emby-${userselected_emby_update_ver}.zip" ]
			#then
			#	echo "$userselected_emby_update_ver.zip found, extracting"
			#    unzip -o "/tmp/emby-${userselected_emby_update_ver}.zip" -d /usr/local/lib/emby-server
			#else
			#	echo "/tmp/emby-${userselected_emby_update_ver}.zip not found, trying 'emby-${emby_def_update_ver}.zip'"
			#fi
            #unzip -o "/tmp/emby-${LATEST_VERSION}.zip" -d /usr/local/lib/emby-server
			pkg install -y /tmp/emby-${LATEST_VERSION}.txz 
            ;;
    esac
}

# Split this function in to multiple parts?
recompile.from.ports ()
{
# Confirm with the user
echo -e "${msg} These steps could take some time and are NOT required.${nc}"
echo -e "${msg} If you're unsure what 'ports' are or if you have them, choose 'No'.${nc}"
read -r -p "   Would you like to recompile these now? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then make a backup before proceeding
              echo " "
              echo -e "${sep}"
              echo -e "${fin} First, lets do ImageMagick${nc}"
              echo -e "${msg} When the options pop up, disable (By pressing space when its highlighted):${nc}"
              echo -e "${inf}    16BIT_PIXEL   ${msg}(to increase thumbnail generation performance)${nc}"
              echo -e "${msg} and then press 'Enter'${nc}"
              echo " "

              update.emby.continue

              cd /usr/ports/graphics/ImageMagick && make deinstall
              make clean && make clean-depends
              make config

              echo " "
              echo -e "${sep}"
              echo -e "${msg} Press 'OK'/'Enter' if any box that follows.${nc}"
              echo -e "${msg}    (There shouldn't be if you have done it before)${nc}"
              echo -e "${sep}"
              echo " "

              update.emby.continue

              make install clean
              #make -DBATCH install clean

              echo " "
              echo -e "${sep}"
              echo -e "${fin} Great, now ffmpeg${nc}"
              echo -e "${sep}"
              echo " "

              cd /usr/ports/multimedia/ffmpeg && make deinstall

              echo " "
              echo -e "${sep}"
              echo -e "${msg} When the options pop up, enable (By pressing space when its highlighted):${nc}"
              echo -e "${inf}    ASS     ${msg}(required for subtitle rendering)${nc}"
              echo -e "${inf}    LAME    ${msg}(required for mp3 audio transcoding -${nc}"
              echo -e "${inf}            ${msg}disabled by default due to mp3 licensing restrictions)${nc}"
              echo -e "${inf}    OPUS    ${msg}(required for opus audio codec support)${nc}"
              echo -e "${inf}    X265    ${msg}(required for H.265 video codec support${nc}"
              echo -e "${msg} Then press 'OK' for any box that follows.${nc}"
              echo -e "${msg} This one may take a while, please be patient${nc}"
              echo -e "${sep}"
              echo " "

              update.emby.continue

              make clean
              make clean-depends
              make config

              echo " "
              echo -e "${sep}"
              echo -e "${msg} Press 'OK'/'Enter' for any box that follows.${nc}"
			  echo -e "${msg}    (There shouldn't be if you have done it before)${nc}"
              echo -e "${sep}"
              echo " "

              update.emby.continue

              #make install clean
              make -DBATCH install clean

              echo " "
              echo -e "${sep}"
              echo -e "${msg} Finished with the recompiling!${nc}"
              echo -e "${sep}"
              echo " "

              ;;
    *)
              # Otherwise continue with update...
              echo " "
              echo -e "${inf} Skipping for now.. (You can do this later via the Emby menu)${nc}"
              ;;
esac
}

remove.downloaded.files ()
{
read -r -p "   Remove downloaded files? [y/N] " response
case "$response" in
    [yY][eE][sS]|[yY])
              # If yes, then make a backup before proceeding
              echo -e "${inf} Deleting files${nc}"
              rm /tmp/emby-*.zip
              rm /tmp/emby-*.txz
              ;;
    *)
              # Otherwise continue with backup...
              echo " "
              echo -e "${inf} Not deleting files${nc}"
              ;;
esac
}

echo " "
echo -e "${sep}"
echo -e "${msg}   Emby Updater${nc}"
echo -e "${sep}"
echo " "
echo " "
echo " "
echo -e "${sep}"
echo -e "${msg} Shall we create a backup before updating?${nc}"
echo -e "${sep}"
echo " "

create.emby.backup

echo " "
echo -e "${sep}"
echo -e "${msg} Updating packages..${nc}"
echo -e "${msg} (You may see some things get uninstalled/reinstalled here)${nc}"
echo -e "${sep}"
echo " "

pkg update
pkg upgrade -y
pkg install -y emby-server # In case it gets uninstalled

echo " "

echo -e "${msg} Package updates done${nc}"

echo " "
echo -e "${sep}"
echo -e "${msg} What version would you like to update to?${nc}"
echo -e "${sep}"
echo " "

select.emby.update.version

echo " "
echo -e "${sep}"
echo -e "${inf} Recompile ffmpeg and ImageMagick${nc}"
echo " "
echo -e "${msg} This is 100% optional but doing so can improve your Emby Server${nc}"
echo -e "${msg}    This can be done either later via Emby menus or now.${nc}"
echo -e "${msg}    Additional information can also be found in the menu.${nc}"
echo -e "${emp} You will also need the 'ports tree' enabled for this to work.${nc}"
echo -e "${sep}"
echo " "

recompile.from.ports

echo " "
echo -e "${sep}"
echo -e "${msg} And finally, start the server back up.${nc}"
echo -e "${sep}"
echo " "

service emby-server start

echo " "
echo -e "${sep}"
echo -e "${msg} Optional: Remove temporary files that were downloaded?${nc}"
echo -e "${sep}"
echo " "

remove.downloaded.files

echo " "
echo -e "${sep}"
echo -e "${msg} That should be it!${nc}"
echo -e "${msg} Now head to your Emby dashboard to ensure it's up to date.${nc}"
echo -e "${msg}    (Refresh the page if you already have Emby open)${nc}"
echo " "
echo -e "${msg} If something went wrong you can do this to restore the old app version:${nc}"
echo -e "${cmd}   rm -r /usr/local/lib/emby-server${nc}"
echo -e "${cmd}   mv /usr/local/lib/emby-server-backups/${date} /usr/local/lib/emby-server${nc}"
echo -e "${cmd}   service emby-server restart${nc}"
echo " "
echo -e "${msg} And use this to restore your server database/settings:${nc}"
echo -e "${cmd}   rm -r /var/db/emby-server${nc}"
echo -e "${cmd}   mv /var/db/emby-server-backups/${date} /var/db/emby-server${nc}"
echo -e "${cmd}   service emby-server restart${nc}"
echo -e "${sep}"
echo -e "${msg} If you have any issues, see the main menu for ways to get help.${nc}"
echo -e "${msg}      Happy Streaming!${nc}"
echo -e "${sep}"
echo " "

update.emby.continue

}

confirm.update.emby

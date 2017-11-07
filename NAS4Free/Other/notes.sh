################################################################################
##### Completed / Almost Complete but fully functional
################################################################################
# Emby
# OwnCloud
# NextCloud


################################################################################
##### In Progress
################################################################################
# Sooo much stuff


################################################################################
##### To-Do's / Future Changes / Planned Additions / etc.
################################################################################

#------------------------------------------------------------------------------#
### General


# FUTURE: Allow users to select owncloud/nextcloud version/ip/port via script
# without the need to edit the script manually.

#------------------------------------------------------------------------------#
### Voice Servers

# LOW-PRIORITY: Finish adding Teamspeak 3 Server & JTS3ServerMod (Server Bot)
# FUTURE: Add "Ventrilo"
# FUTURE: Add "Murmur" (Mumble)

#------------------------------------------------------------------------------#
### Media Download / Search / Management

# FUTURE: Add "Mylar" (Comic Books)
# FUTURE: Add "LazyLibrarian" (Books)
# FUTURE: Add "Sickbeard" (TV/Anime)
# FUTURE: Add "XDM"
# FUTURE: Finish adding "Calibre" (Books)

# FUTURE: Add "Radarr"
# FUTURE: Add "Watcher" (Movies - CouchPotato Alternative)


# FUTURE: Add "HTPC Manager" (Combines many services in one interface)

# FUTURE: Add "NZBHydra" (Meta search for NZB indexers)
# FUTURE: Add "Jackett" (Meta search for torrents)

# LOW-PRIORITY: Finish "Deluge" scripts (Lots of issues with it)

#------------------------------------------------------------------------------#
### Media Server

# FUTURE: Add "Plex"
    # Maybe utilize ezPlex Portable Addon by JoseMR? (With permission of course)

        # INSTALL
        # cd $(myappsdir)
        # fetch https://raw.githubusercontent.com/JRGTH/nas4free-plex-extension/master/plex-install.sh && chmod +x plex-install.sh && ./plex-install.sh

        # UPDATE
        # fetch https://raw.githubusercontent.com/JRGTH/nas4free-plex-extension/master/plex/plexinit && chmod +x plexinit && ./plexinit

    # Or make use of OneButtonInstaller by "Crest"
    # If not, use ports tree or whatever, will decide later.

# FUTURE: Add "Serviio"
# FUTURE: Add "SqueezeBox"
# FUTURE: Add "UMS (Universal Media Server)"
# FUTURE: If this script has no issues then i may remove standalone scripts from github
# FUTURE: IF & when jail creation via shell is possible for thebrig, will add that option to script.

#------------------------------------------------------------------------------#
### Web Server / Cloud Server

# FUTURE: Add "Pydio"

#------------------------------------------------------------------------------#
### Databases

# FUTURE: Add "MariaDB"

#------------------------------------------------------------------------------#
### System Monitoring

# LOW-PRIORITY: Finish adding "Munin"

# FUTURE: Add "Monit" (Free) & "M/Monit" (Free Trial but requires purchase)
# "M/Monit" is NOT required to be able to use "Monit"
    #pkg install monit
    #echo 'monit_enable="YES"' >> /etc/rc.conf
    #cp /usr/local/etc/monitrc.sample /usr/local/etc/monitrc
    #chmod 600 /usr/local/etc/monitrc
    #service monit start
# FUTURE: Add "Zabbix"
# FUTURE: Add "Pandora"
# FUTURE: Add "Icinga"
# FUTURE: Add "Observium"
# FUTURE: Add "Cacti"
# FUTURE: Add "Nagios"
# FUTURE: Add "nTop"
# FUTURE: Add "Grafana"

#------------------------------------------------------------------------------#
### XMPP Server

# FUTURE: Add "Jabber" Server (Or Prosody as i'm pretty sure that is easier to set up)
    #pkg install ejabberd
    #echo 'ejabberd_enable="YES"' >> /etc/rc.conf
    #cp /usr/local/etc/ejabberd/ejabberd.yml.example /usr/local/etc/ejabberd/ejabberd.yml
    #chown 543:543 /usr/local/etc/ejabberd/ejabberd.yml
    #service ejabberd start

#------------------------------------------------------------------------------#
### Other

# FUTURE: Add "Mail Server"
# FUTURE: Add OneButtonInstaller
    # http://www.nas4free.org/forums/viewtopic.php?f=71&t=11189
    # fetch https://raw.github.com/crestAT/nas4free-onebuttoninstaller/master/OBI.php && mkdir -p ext/OBI && echo '<a href="OBI.php">OneButtonInstaller</a>' > ext/OBI/menu.inc && echo -e "\nDONE"


################################################################################
# By Ashley Townsend (Nozza)    Copyright: Beerware License
################################################################################

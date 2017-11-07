################################################################################
##### START OF CONFIGURATION SECTION #####
#
#   In some instances of this script, the following variables must be defined
#   by the user:
#
#   cloud_server_port:  Used to specify the port OwnCloud will be listening to.
#                       Needed due to some installs of N4F having trouble with
#            the admin webgui showing up, even when browsing to the jail's IP.
#
#
#   cloud_server_ip:    This value is used to specify the ip address Owncloud
#                       will listen to. This is needed to keep the jail from
#            listening on all ip's
#
###! OWNCLOUD / NEXTCLOUD INSTALLER CONFIG ! IMPORTANT ! DO NOT IGNORE ! #######

cloud_server_port="81"
cloud_server_ip="192.168.1.200"
cloud_database_name="nextcloud" # Only needed for nextcloud, owncloud can ignore
owncloud_version="9.0.0"        # The version of ownCloud you wish to install.
                        # You can set this to "latest" but it isn't recommended
                        # as owncloud updates may require an updated script.
nextcloud_version="11.0.2"      # Same as owncloud_version but for nextcloud.

##! END OF OWNCLOUD / NEXTCLOUD INSTALLER CONFIG ! IMPORTANT ! DO NOT IGNORE ! ##
###! No need to edit below here unless the script asks you to !###
##### OWNCLOUD / NEXTCLOUD UPDATER CONFIG #####
owncloud_update="latest"    # This can be safely ignored unless you are planning
                        # on using the updater in this script (not recommended)
                        # It's best to leave it alone and let owncloud update itself
################################################################################
##### OTHER APPS CONFIGURATION #####
jail_ip="192.168.1.200"   # ! No need to change this for OwnCloud installs !
                          # Only change this for OTHER jails/apps
                        # MUST be different to cloud_server_ip if you have
                        # installed OwnCloud previously.
################################################################################
###! EMBY CONFIG !###
emby_def_update_ver="3.2.13.0"  # You can find release numbers here:
                        # https://github.com/MediaBrowser/Emby/releases
                        # Example, To use the beta: "3.0.5947-beta"
                        # Example, To use the dev: "3.0.5966.988-dev"
################################################################################
###! SABNZBD CONFIG !###
sab_ver="2.0.0"         # You can find release numbers here:
                        # https://github.com/sabnzbd/sabnzbd/releases
################################################################################
###! SUBSONIC / MADSONIC CONFIG !###
subsonic_ver="6.0"      # You can find release numbers here:
                        # sourceforge.net/projects/subsonic/files/subsonic
madsonic_ver="6.2.9040" # http://beta.madsonic.org/pages/download.jsp
################################################################################
###! THEBRIG CONFIG !###
# Define where to install TheBrig
thebriginstalldir="/mnt/Storage/System/Jails"
thebrigbranch="alcatraz"    # Define which version of TheBrig to install
                        # master   - For 9.0 and 9.1 FreeBSD versions
                        # working  - For 9.1 and 9.2 FreeBSD versions
                        # alcatraz - For 9.3 and 10.x FreeBSD versions
# thebrigversion="3"    # Not needed anymore

###! END OF THEBRIG CONFIG !###
################################################################################
### OTHER ###
# Modify this to reflect your storage location
mystorage="/mnt/Storage"
myappsdir="/mnt/Storage/Apps"
##################################################
###! CALIBRE CONFIG !#############################
# Modify to where you store all of your books.
CALIBRELIBRARYPATH="/mnt/Storage/Media/Books"
##################################################
###! MUNIN CONFIG !###############################
# Enter the jail name you wish to run Munin in
#muninjail="Munin"   # Unused currently
                     # (For a future idea)
##################################################
###! NZBGET CONFIG !##############################
#nzbgetjail="NZBGet" # Unused currently
                     # (For a future idea)
##################################################
###! DELUGE CONFIG !##############################
#delugejail="Deluge" # Unused currently
user_ID="UID"
deluge_user="JonDoe"
deluge_user_password="MyC0mpL3xPass"
##################################################
##### END OF CONFIGURATION SECTION #####
################################################################################

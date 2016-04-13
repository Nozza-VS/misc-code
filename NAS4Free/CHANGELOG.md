# Changelog

### Version: 1.0.20 (April 13, 2016)
* Modified menus a bunch
   + Added new submenu for download automation tools
+ Started adding Teamspeak
   + Menus
   + Menus for Server Bot

### Version: 1.0.19.1 (April 12, 2016)
* Updated support email
* Modified menu

### Version: 1.0.19 (April 11, 2016)
+ Updated a couple configs to show user how to find latest version numbers
+ Added Subsonic (Unfinished)
   + Installer (Unfinished)
   + Menus
   + About
* Updated TheBrig How-To: Enable the ports tree in jails
+ Added SABnzbd updater (Unfinished)
* Updated a few Plex Media Server items
   + About
   + Menus
+ Added a couple things for future changes to menu

### Version: 1.0.18 (April 11, 2016)
+ Added About: SABnzbd
* Updated About: Pydio
+ Added TheBrig How-To: mounting storage in jails via fstab
* Modified emby updater to make ports tree reconfig a bit more automated

### Version: 1.0.17 (April 10, 2016)
* Updated SABnzbd installer
   * Reworked packages (split in to 3 commands) as they weren't all installing in the 1 command
   + Added information about editing sabnzbd.py
   + Added information on where to go to complete setup
   * Fixed incorrect sabnzbd download URL
   * Fixed incorrect paths in script
+ Added commands to make certain files executable as needed

### Version: 1.0.16 (April 9, 2016)
+ Added SABnzbd
   + Installer
   + Menus
* Updated Emby updater - will use -DBATCH for ports to make it more automated
* Updated a couple more menus to show the options are currently unavailable

### Version: 1.0.15.2 (April 6, 2016)
* Fixed a couple more issues that caused problems with the script

### Version: 1.0.15.1 (April 6, 2016)
+ Added Emby How-To: restarting the emby server
* Fixed issue with script that caused it to not work

### Version: 1.0.15 (April 6, 2016)
+ Added command to delete a couple temp txt files made for owncloud
* Fixed typo
- Removed 'safe' emby updater as it has the same effect as the git method
* Emby update from git method is now just emby update
* Updated Emby updater
   + Added notifier for what version Emby is set to update to
   + Added recompiling options for ffmpeg & imagemagick
   + Made the recompile ffmpeg/imagemagick optional
   + Added notice to emby updater about recompiling from ports
   - Removed a couple unnecessary lines
   + Added option to delete old backups, if any, to free up space
   + Updated menus


### Version: 1.0.14 (April 4, 2016)
+ Didn't realize i forgot the emby update version variable so added that
* Made the backup in both of the Emby updaters optional

### Version: 1.0.13.1 (April 3, 2016)
* Forgot to comment out a line which broke the script, oops! Fixed now

### Version: 1.0.13 (April 3, 2016)
+ Added underline text formatting to make things stand out even more where needed ( bold doesn't seem to work for me anymore, same with italics :(  )
   * Used new underline to empasize a couple things
* Fixed some missing menu items
* Modified menus to show things that are currently not fully implemented and disabled access to them
   + Added new darker text for this too
+ Added new menu for streaming services, will move emby here and add plex later
+ Added some spacers in a few areas to make some output text look a bit nicer
* A lot of menus were missing the "invalid choice" notification, fixed that up
+ Added menu for self hosting services, this will be where the "web server", "cloud storage" and (in the future) "game servers" menus will live
   + Moved Web Server and Cloud Storage to this menu
* Change "confirm.*.update" / "confirm.*.install" done, this was mainly for myself as it makes searching for things easier

### Version: 1.0.12 (April 3, 2016)
+ Added NZBGet installer
   * Still need to add command to get web interface on by default
+ Added NZBGet updater, nothing really special needed here
+ Added OwnCloud updater
   + Added warnings to confirmation
* Made certain items unavailable so people are unable to use them for now
+ Added a notice to owncloud installer about potential "untrusted domain" warnings
+ Added missing spacers above "main menu" & "back" menu options


### Version: 1.0.11 (April 2, 2016)
* Fixed an issue in the deluge installer that broke the script
* Fixed a couple deluge variables also
+ Add missing confirmation to deluge installer
+ Added "Web Server"
   + Menus
   + Confirmations for installer/updater
   + Installer (Very much unfinished, just merging from an old script of mine)
   + Updater (Still need to start on this)
* Changed "cloud" to "owncloud" to get ready for addition of "Pydio"
+ Added "About Pydio" kind of, will revise this later as the description from the website wasnt very "About-ish"
* Modified main menu to make it smaller
   + Added new submenu for "download tools (nzbget/deluge)" and "self hosted cloud services (owncloud/pydio)"

### Version: 1.0.10 (April 2, 2016)
+ Added info about how to navigate inside nano and how to save once done editing
+ Added Deluge
   + Added "About" Deluge
   + Menu & Submenus (Unfinished)
   + Confirmations for installer/updater
   + Installer (Very much unfinished, just merging from an old script of mine)
   + Updater (Still need to start on this)
+ Added NZBGet
   + Added "About" NZBGet
   + Menus
   + Configuration (Not used yet, for a future idea)
   + Basis of Installer
   + Confirmations for installer/updater
   + Updater (Still need to start on this)
* Changed "OWNCLOUD - ENABLE MEMORY CACHING" to need a keypress to go back

I should stop adding things and actually finish what is here already...

### Version: 1.0.9 (April 2, 2016)
+ Fixed a few more typos
- Removed a couple obselete things
   - TheBrig no longer needs a 1,2 or 3 for the install command
+ Added information on where to report issues
+ Added "About" information such as what the apps are for/do (Mostly just taken from the description pages of each thing)
   + About The script
   + About MySQL
   + About ownCloud
   + About Emby Media Server
   + About Sonarr
   + About CouchPotato
   + About Headphones
   + About TheBrig
* Moved a menu (in the script only, in the same location when running the script)
   * OwnCloud Error Fix Submenu looked out of place in the area it was in

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/a649b2bbd6ed3e6361a1d4ebfdad9335ed20cfac)

### Version: 1.0.8 (March 31, 2016)
+ Added configurations for munin, calibre & deluge
+ Started working on Calibre installer

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/d23bcee236fff93059e33da6a841ecf6e1962ab5)

### Version: 1.0.7.1 (March 31, 2016)
* I'm terrible at making sure i update version numbers and dates...

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/44fad9f76af6f4e82167d4df2366f2419300c38f)

### Version: 1.0.7 (March 31, 2016)
* Updated Sonarr installer
   - Removed ffmpeg, not needed
   + Added information on how to get to Sonarr
* Updated CouchPotato installer
   * Changed how we grab CouchPotato from git
   * Fixed up mistake of Emby in place of CouchPotato
   + Added Couchpotato website url
* Updated Headphones installer
   * Changed git download to be placed directly in correct folder
* Updated Emby Updaters
   * Fixed info line for backups
   + Added more detail to 'safe' method updater
   + Added backup to 'safe' method
* Updated CouchPotato updater
   * Sort of... just adding reminders for myself
* Updated Headphones updater
   * Again, sort of... adding reminders here as well
* Updated a couple menus

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/f4249a7da70924b288cfa2bd96d387f1a2c6c62f)

### Version: 1.0.6.1 (March 31, 2016)
* Nothing special, just correcting some spelling mistakes

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/1db1960e163cca7d46b0447243749b9046a85aab)

### Version: 1.0.6 (March 31, 2016)
Made 2 commits with same version number, derp.

* Updated a How-To: Install TheBrig
* Updated Emby Server installer
   + Now has messages of actions being performed
* Updated Sonarr installer
   + Additional packages added
* Updated CouchPotato installer
   + Added messages of actions being performed
   + Added information of where to go to finish setup
   + Added link to project github page
* Updated Headphones installer
   + Added messages of actions being performed
   * Updated required packages to be downloadeed
   * Updated link to my init script for automatic startup
   + Added information of where to go to finish setup
   + Added link to project github page
   
+ Added confuration for thebrig installer
* Getting ready to add How-To for installing thebrig manually
+ Added information about thebrig Rudimentary Configuration
+ Added thebrig installer (Untested)
* Updated thebrig submenu
+ Added warning about using thebrig auto installer

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/d55ebcde4d17d1b6b248e5fdf68bdc66eae529e5)
[See the commit here](https://github.com/Nostalgist92/misc-code/commit/7bdeb3586efbb33184272f44612b33aec89faacb)

### Version: 1.0.5 (March 30, 2016)
* updated OwnCloud Memory Caching fix
 * Will add auto or manual options at a later date
 
[See the commit here](https://github.com/Nostalgist92/misc-code/commit/eb60400f38ee01cd9607300e81501cdd76a2f7dc)

### Version: 1.0.4 (March 28, 2016)
+ Added menu for TheBrig
+ Added TheBrig how-to for creating a jail
+ Added Emby how-to for updating FFMpeg
+ Added TheBrig install (Untested and probably won't work)
* Seperating "more info menus" for better placement later

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/5dad89ae79ae06d76899437f1a26b5901024e0c4)

### Version: 1.0.3 (March 28, 2016)
+ Added some stuff for readability both when using the script as well as for when i modify it
+ Added placeholders for some information i'll be adding later
* Merged Emby Server install/update/backup from my other script
* Some other small misc changes

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/f32a6b22b811da8b45c317e3ad9385fef3838400)

### Version: 1.0.2 (March 28, 2016)
* Modified help section a bit
+ Added "Memory Caching" for owncloud
+ Added "Trusted Domain" warning fix
+ Added "Populating Raw Post Data" Fix
* Fixed an owncloud variable
+ Added notices about unfinished parts of the script
+ Added confirmations 
* Improved script readability (mainly for myself)
+ Added submenus

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/db6ded828d67f5818d6715a050bea0394aff2f5d)

### Version: 1.0.1 (March 19, 2016)
+ Initial upload

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/f1ce4de7ae6b08b315a4531dc8f01cbb299f04cc)

### Version: 1.0.0

Apparently i skipped initial 1.0 commit and went straight to 1.0.1
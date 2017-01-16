# Changelog

### Version: 1.0.30 (January 17, 2017)
* Madsonic
    * Fixed updater
* SABnzbd
    * Changed SAB default version to 1.2.0 (https://github.com/sabnzbd/sabnzbd/releases/tag/1.2.0)
* Pydio
    + Some inital groundwork on installer
* General
    * Updated some menu items

### Version: 1.0.29 (January 15, 2017)
* Emby
    * Modified script to let user choose version to update to without the need to modify script
* Madsonic
    * Finished installer, should work but untested
    + Added updater
* NextCloud
    * Fixed installer, still had some owncloud leftovers in it
* General
   * Some minor cleanup
   * More To-Do's and such
   * Need to fix menu items

### Version: 1.0.28 (January 15, 2017)
* TheBrig
    * Removed some of TheBrig options in favor of OneButtonInstaller
* Emby
    * Updated version to 3.1.2
* Subsonic
    * Enabled menu item (Untested - use with caution)
+ Added Madsonic (incomplete)
+ Added NextCloud
+ Added Sickbeard (incomplete, use with caution)


### Version: 1.0.27 (September 18, 2016)
* Emby
    * Updated version to .7200
    * Tweaked confirmation with a bit more info

### Version: 1.0.26 (August 26, 2016)
* MySQL
    * Made update option available 
* Plex Server
    + Started on installer. Currently untested from within this script.
    + Started on updater. Currently untested from within this script.
* Subsonic
    * Changed the section it was in the script.
* OneButtonInstaller
    + Added OBI menus. Just placeholders for now.

### Version: 1.0.25 (August 21, 2016)
* Emby changes
   * Updated Emby version to latest (3.0.6070)
+ More To-Do list stuff

### Version: 1.0.24 (August 1, 2016)
* Cleanup
* Emby changes
   * Updated Emby versions to latest (3.0.6020)
   * Recompile ports option now working as intended
* General
   * Some minor cleanup

### Version: 1.0.23 (May 26, 2016)
* Fixed folder not being created for backups
* Fixed "Press enter to continue" only working once in emby update.

### Version: 1.0.22 (May 2, 2016)
* Emby changes
   * Updated Emby versions to latest
   + Recompile ffmpeg/imagemagick from ports option
   + Add option to delete temp files
+ Added some more notes (Will import in to menus later)

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/6a618177fbdb703369ab908b3b6bc1b46a571839)

### Version: 1.0.21 (April 18, 2016)
* Changed Emby version to latest (3.0.5930)
* Updated Teamspeak & Bot a bit more (Still Unfinished)

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/8568c1a156bc7c72fcfa00fa07d3bfef8f3b89b1)

### Version: 1.0.20 (April 13, 2016)
* Modified menus a bunch
   + Added new submenu for download automation tools
+ Started adding Teamspeak
   + Menus
   + Menus for Server Bot

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/f73a575635a658a2493977e77ac671ec279886e6)

### Version: 1.0.19.1 (April 12, 2016)
* Updated support email
* Modified menu

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/daaedc2869c6c41ac1ee2a7dd350056cacdf506f)

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

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/c21047ea6b8b34e1380a5cc1f2eb41dccefe5143)

### Version: 1.0.18 (April 11, 2016)
+ Added About: SABnzbd
* Updated About: Pydio
+ Added TheBrig How-To: mounting storage in jails via fstab
* Modified emby updater to make ports tree reconfig a bit more automated

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/5cd8ffe363eeb33297244f32e5c80ba10f0c07f3)

### Version: 1.0.17 (April 10, 2016)
* Updated SABnzbd installer
   * Reworked packages (split in to 3 commands) as they weren't all installing in the 1 command
   + Added information about editing sabnzbd.py
   + Added information on where to go to complete setup
   * Fixed incorrect sabnzbd download URL
   * Fixed incorrect paths in script
+ Added commands to make certain files executable as needed

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/b806afd796587a6a5a97887fd07a5b395bb56843)

### Version: 1.0.16 (April 9, 2016)
+ Added SABnzbd
   + Installer
   + Menus
* Updated Emby updater - will use -DBATCH for ports to make it more automated
* Updated a couple more menus to show the options are currently unavailable

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/ee775943ddf1802fb9852a374e479b33f66b43bc)

### Version: 1.0.15.2 (April 6, 2016)
* Fixed a couple more issues that caused problems with the script

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/31cb2483102777942b0d8be6d327fab9754921aa)

### Version: 1.0.15.1 (April 6, 2016)
+ Added Emby How-To: restarting the emby server
* Fixed issue with script that caused it to not work

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/bae12c6f99387fa5201426505f0be39b25f649da)

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

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/3d95a7e2c4c603b0f69a78d8b7ac9f047dc59e87)

### Version: 1.0.14 (April 4, 2016)
+ Didn't realize i forgot the emby update version variable so added that
* Made the backup in both of the Emby updaters optional

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/d17d4697d0db66fdfd7fb2d8c1c364f4a852450d)

### Version: 1.0.13.1 (April 3, 2016)
* Forgot to comment out a line which broke the script, oops! Fixed now

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/e869d6f15478027cd0975ecf0409830391b8f8be)

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

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/5d8e89683d7765ab5618c6be0b51a4729fde7668)

### Version: 1.0.12 (April 3, 2016)
+ Added NZBGet installer
   * Still need to add command to get web interface on by default
+ Added NZBGet updater, nothing really special needed here
+ Added OwnCloud updater
   + Added warnings to confirmation
* Made certain items unavailable so people are unable to use them for now
+ Added a notice to owncloud installer about potential "untrusted domain" warnings
+ Added missing spacers above "main menu" & "back" menu options

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/7e58cc4ef934afb83c8065d2ee8230346c2d385f)

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
   
[See the commit here](https://github.com/Nostalgist92/misc-code/commit/858f43a04f29dd787b68cd5c2074c2e466f76c69)

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

[See the commit here](https://github.com/Nostalgist92/misc-code/commit/2cfb57b29dc9965179d3deeeeb8bf4b270026c47)

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
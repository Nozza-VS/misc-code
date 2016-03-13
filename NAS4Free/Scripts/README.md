# Monitoring Scripts

##### check_firmware_update.sh & check_firmware_update.php:
Checks if new firmware version is available. In case this is true, it sends an email and creates a file in /tmp which is checked everytime, so that you get just one email. If /tmp gets wiped (e.g. reboot) this script will send an email again. may be run as a cronjob


##### check_temp.sh:
  * __YOU NEED MBMON FOR THIS__   
Checks some temperatures and the fan, may not be suitable for everyone. My system detects wrong temperatures in the webinterface, so I wrote this. Thresholds are configurable in config.sh, may be run as a cronjob


##### scrubbing.sh
Thanks to gimpe, this is basically his script! This starts a scrub on every zfs pool and reports via email when finished. may be run as a cronjob


##### zfs_errors.sh
Check if zfs pools are in good condition, if not sends an email. may be run as a cronjob


##### mount_opt.sh & umount_opt.sh
Mounts and unmounts unionfs (used to install additional packages on embedded). configure MOUNTPOINT in config.sh, when run with '-s' mounting is delayed by 60 seconds (SLEEPTIME). may be run at startup


##### fuppes_update_db.sh
Updates fuppes db, workaround for latest NAS4Free version because /etc/rc.d/fuppes updatedb is broken. curl needs to be installed! may be run as a cronjob
___
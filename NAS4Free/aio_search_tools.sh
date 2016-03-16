#!/bin/sh
# Script Version: 1.0 (March 16, 2016)
# NOTE: Untested & Unfinished



# Sonarr Installation (Covers TV Shows)

pkg install sonarr

# Change sonarr user to root
#sed command thingy to change from sonarr to root



# CouchPotato Installation (Covers Movies)

#Update your repo catalog
pkg update

#Install required tools
pkg install python py27-sqlite3 fpc-libcurl docbook-xml git-lite

#For default install location and running as root
cd /usr/local

#If running as root, expects python here
ln -s /usr/local/bin/python /usr/bin/python

#get couchpotato from git
git clone https://github.com/CouchPotato/CouchPotatoServer.git

#Copy the startup script
cp CouchPotatoServer/init/freebsd /usr/local/etc/rc.d/couchpotato

#Make startup script executable
chmod 555 /usr/local/etc/rc.d/couchpotato

#Add startup to boot
echo 'couchpotato_enable="YES"' >> /etc/rc.conf

#Read the options at the top of more /usr/local/etc/rc.d/couchpotato
#If not default install, specify options with startup flags in ee /etc/rc.conf
#Finally,

service couchpotato start
#Open your browser and go to: http://server:5050/



# Headphones Installation (Covers Music)
git clone https://github.com/rembo10/headphones.git

#Copy the startup script
# cp headphones/init-scripts/init.freebsd /usr/local/etc/rc.d/headphones
#Fetch Nostalgist92's startup script instead

#Make startup script executable
chmod 555 /usr/local/etc/rc.d/headphones

#Add startup to boot
echo 'headphones_enable="YES"' >> /etc/rc.conf

#Start the server
service headphones start

#Open your browser and go to: http://server:headphonesport?/

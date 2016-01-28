#!/bin/bash

# author: the-razer on nas4free.org forums
# last update: 13.09.12
#
# some config values for some
# scripts, make your adjustments
# here!

# mail config | you have to setup System->Advanced->Email !
TO="mail@goes.here"
FROM="NAS4Free Server <mail@comesfrom.here>"
SUBJECT_PREFIX="[NAS]"

# notify when temperature exceeds this threshold (in °C)
TEMP_THRESH=50

# notify when fan runs slower then this threshold
FAN_THRESH=400

# unionfs config
# delay when mounting unionfs in seconds
SLEEPTIME=60
# mount point of data partition, this is usually /mnt/NAME
MOUNTPOINT=/mnt/opt

# define name of this server (used in mail subject)
HOSTNAME=`hostname`

# environment
PRINTF=/usr/bin/printf
MSMTP=/usr/local/bin/msmtp
MSMTPCONF=/var/etc/msmtp.conf   
MBMON=/usr/local/bin/mbmon
GREP=/usr/bin/grep
CUT=/usr/bin/cut
ZSTATUS="/sbin/zpool status"


if [ -n "$SUBJECT_PREFIX" ]
then
    # add a space after prefix when set
    SUBJECT_PREFIX="$SUBJECT_PREFIX "
fi

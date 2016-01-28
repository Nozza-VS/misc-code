#!/bin/bash

# author: the-razer on nas4free.org forums
# last update: 13.09.12
#
# mount unionfs so that you
# install software even with
# an embedded install

# include config file which is in the same directory
. ${0%/*}/config.sh

if [ "$1" = "-s" ]
then
    echo "sleeping for $SLEEPTIME seconds ..."
    sleep $SLEEPTIME
fi


if [ ! -d $MOUNTPOINT/var_db ]
then
    mkdir $MOUNTPOINT/var_db
fi


if [ ! -d $MOUNTPOINT/usr_local ]
then
    mkdir $MOUNTPOINT/usr_local
fi


mount -t unionfs $MOUNTPOINT/var_db /var/db
mount -t unionfs $MOUNTPOINT/usr_local /usr/local

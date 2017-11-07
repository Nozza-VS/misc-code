#!/bin/bash

# author: the-razer on nas4free.org forums
# last update: 13.09.12
#
# check for firmware updates and
# send a mail when a newer version
# is found (will resend when machine
# gets rebooted)

# include config.sh which is in the same directory
. ${0%/*}/config.sh

PHP_SCRIPT=${0%/*}/check_firmware_update.php
TMP=/tmp

SUBJECT="New firmware for $HOSTNAME"

UPDATES=`$PHP_SCRIPT`
FULLNAME=`echo "$UPDATES" | $GREP -v http`
LINK=`echo "$UPDATES" | $GREP http`
README=`echo "$LINK" | $CUT -d/ -f 1-8`

if [ -n "$(echo $UPDATES | $GREP http)" ] && [ ! -f "$TMP/$FULLNAME" ];
then
    FULLNAME=`echo "$UPDATES" | $GREP -v http`
    LINK=`echo "$UPDATES" | $GREP http`

    touch "$TMP/$FULLNAME"

    BODY="New version: $FULLNAME \n"
    BODY="${BODY}Link: $LINK \n\n"

    BODY="${BODY}Readme: $README \n"
    BODY="${BODY}Changelog: http://nas4free.svn.sourceforge.net/viewvc/nas4free/trunk/?view=log"

    #compose mail
    $PRINTF "From:$FROM\nTo:$TO\nSubject:${SUBJECT_PREFIX}$SUBJECT\n\n$BODY" | $MSMTP --file=$MSMTPCONF -t
    echo "mail sent."
fi


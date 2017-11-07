#!/bin/bash

# author: the-razer on nas4free.org forums
# last update: 13.09.12
#
# check for ZFS errors and send
# a mail when something is wrong

# include config file which is in the same directory
. ${0%/*}/config.sh


# check for errors
DEGRADED=`$ZSTATUS | grep DEGRADED`
UNAVAIL=`$ZSTATUS | grep UNAVAIL`
DATAERROR=`$ZSTATUS | grep "Permanent errors have been detected"`


if [ -n "$DEGRADED" ] || [ -n "$UNAVAIL" ] || [ -n "$DATAERROR" ]
then

    OUTPUT=`$ZSTATUS`

    #compose mail
    SUBJECT="ZFS error on $HOSTNAME"
    $PRINTF "From:$FROM\nTo:$TO\nSubject:${SUBJECT_PREFIX}$SUBJECT\n\n$OUTPUT" | $MSMTP --file=$MSMTPCONF -t

    echo "mail sent."

fi

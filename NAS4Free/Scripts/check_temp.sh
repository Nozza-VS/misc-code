#!/bin/bash

# author: the-razer on nas4free.org forums
# last update: 13.09.12
# 
# check cpu temperature and fan
# speed and send a mail if values 
# exceed threshold
# NOTICE: mbmon needs to be installed!
# do: pkg_add -r mbmon

# include config.sh which is in the same directory
. ${0%/*}/config.sh

if [ ! -x "$MBMON" ]
then
    echo "mbmon not installed! please check config.sh! aborting ..."
    exit 1
fi


# gather temperatures and fan speed
T1=`$MBMON -c1 -T1`
T1=`$PRINTF "%0.f\n" $T1`

T2=`$MBMON -c1 -T2`
T2=`$PRINTF "%0.f\n" $T2`

T3=`$MBMON -c1 -T3`
T3=`$PRINTF "%0.f\n" $T3`

FAN=`$MBMON -c1 -F1`


ERROR=0
SUBJECT="on $HOSTNAME"


if [ $T1 -gt $TEMP_THRESH ] || [ $T2 -gt $TEMP_THRESH ] || [ $T3 -gt $TEMP_THRESH ]
then
    echo "At least one temperature exceeds threshold of $TEMP_THRESH°C."
    SUBJECT="CPU temperature too high ${SUBJECT}"
    ERROR=1
fi

if [ $FAN -lt $FAN_THRESH ]
then
    echo "The fan failed."
    SUBJECT="Fan failed ${SUBJECT}"
    ERROR=1
fi


if [ $ERROR -eq 1 ]
then
    # compose mail
    
    OUTPUT=`$MBMON -c1`
    
    $PRINTF "From:$FROM\nTo:$TO\nSubject:${SUBJECT_PREFIX}$SUBJECT\n\n$OUTPUT" | $MSMTP --file=$MSMTPCONF -t
    
    echo "mail sent."
fi

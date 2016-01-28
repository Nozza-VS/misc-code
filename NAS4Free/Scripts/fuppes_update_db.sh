#!/bin/bash

# author: the-razer on nas4free.org forums
# last update: 13.09.12
#
# update fuppes database

HOSTNAME=`hostname`

OK=`curl -s \
-H "Soapaction: \"urn:fuppes:service:SoapControl:1#DatabaseUpdate\"" \
-H "Content-Type: text/xml; charset=utf-8" \
-X POST \
-d '<?xml version="1.0"?><s:Envelope xmlns:s="http://schemas.xmlsoap.org/soap/envelope/" s:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/"><s:Body><u:DatabaseUpdate xmlns:u="urn:fuppes:service:SoapControl:1"></u:DatabaseUpdate></s:Body></s:Envelope>' \
http://$HOSTNAME:49152`

if [ -n "$(echo $OK | grep OK)" ]
then
    echo "updating db"
    exit 0
else
    echo "error"
    exit 1
fi

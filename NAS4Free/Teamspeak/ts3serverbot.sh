#!/bin/sh

# /teamspeak_server/ts3server_startscript.sh start
#screen -dm -tS TS3 TS3 /teamspeak_server/ts3server_minimal_runscript.sh

# screen -dm -tS TS3 TS3 /teamspeak_server/ts3server_startscript.sh start
sleep 2
screen -dm -tS TS3Bot TS3Bot java -jar /teamspeak_server/serverbot/JTS3ServerMod.jar -config /teamspeak_server/serverbot/config/JTS3ServerMod_InstanceManager.cfg -log /teamspeak_server/serverbot/logs/instance.log

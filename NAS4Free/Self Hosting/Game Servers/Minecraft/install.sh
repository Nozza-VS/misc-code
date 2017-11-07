#!/bin/sh
# Script Version: TESTING-1.0 (March 10, 2016)
#	Install script for Minecraft Server in a jailed environment.
#   See http://forums.nas4free.org/viewtopic.php?f=79&t=5347 or
#   http://forums.nas4free.org/viewtopic.php?f=79&t=1159 for more info.
#   Copyrighted 2016 by Ashley Townsend under the Beerware License.

##### START CONFIGURATION #####

# Create a jail within nas gui and note the ID it is given, add that ID here.
# You can also use the name of the jail instead as the ID may change.
minecraftversion="1.7.2"


##### END CONFIGURATION #####

pkg install nano openjdk7

mkdir -p /srv/minecraft
cd /srvminecraf
fetch https://s3.amazonaws.com/Minecraft.Download/versions/$minecraftversion/minecraft_server.$minecraftversion.jar

echo " You can run the server using this command:"
echo "java -Xmx1024M -Xms1024M -jar minecraft_server.$minecraftversion.jar nogui"
echo " For now, this script will run it for the first time."
java -Xmx1024M -Xms1024M -jar minecraft_server.$minecraftversion.jar nogui

echo "After initial startup it should build your directory structure as such:"
echo " "
echo "/srv/minecraft # ls"
echo " "
echo "   banned-ips.txt                  ops.txt"
echo "   banned-players.txt              server.properties"
echo "   logs                            white-list.txt"
echo "   minecraft_server.1.7.2.jar      world"
echo " "
echo " "
echo " "
ls
echo " "
echo " "
echo " "
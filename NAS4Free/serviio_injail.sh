#!/bin/sh
# Script Version: TESTING-1.0 (March 10, 2016)
#	Install script for Serviio in a jailed environment
#   See http://forums.nas4free.org/viewtopic.php?f=79&t=4502 for more info.
#   Copyrighted 2016 by Ashley Townsend under the Beerware License.

# Add some colour!
nc='\033[0m'        # No Color
alt='\033[0;31m'    # Alert Text
emp='\033[1;31m'    # Emphasis Text
msg='\033[1;37m'    # Message Text
url='\033[1;32m'    # URL
qry='\033[0;36m'    # Query Text
sep='\033[1;30m-------------------------------------------------------\033[0m'    # Line Seperator
cmd='\033[1;35m'    # Command to be entered

# Build ffmpeg1 and make sure the correct options (listed below) are selected:

cd /usr/ports/multimedia/ffmpeg1
echo " Build with these options:"
echo " AMR_NB AMR_WB ASS FAAC FFSERVER FREI0R ICONV"
echo " LAME RTMP THEORA VORBIS VPX X264 XVID"
make config
make install clean

# Build Java
cd /usr/ports/java/openjdk6
echo " Default options are fine for this build"
make install clean

# Fetch and install Serviio.
cd /tmp
fetch http://kairoh.bitbucket.org/serviio-webui/dist/serviio-webui-unix-1.0.1-c.tar.gz
fetch http://download.serviio.org/releases/serviio-1.2.1-linux.tar.gz
tar xvf serviio-1.2.1-linux.tar.gz -C /usr/local/etc/
mv /usr/local/etc/serviio-1.2.1 /usr/local/etc/serviio
tar xvf serviio-webui-unix-1.0.1-c.tar.gz -C /usr/local/etc/serviio
mkdir /usr/local/etc/prefs

pw groupadd dlna -g 933
pw useradd dlna -g dlna -u 933 -s /usr/sbin/nologin -c "DLNA Daemon" -d /usr/local/etc/serviio/prefs/
chown -R dlna:dlna /usr/local/etc/serviio
chown -R dlna:dlna /usr/local/etc/prefs

# Now edit /etc/hosts file inside your jail, and add an entry with your jail's IP address and hostname.
echo "192.168.1.205       serviio.local"

# Create a /usr/local/sbin/serviiod file, and fill it with:
#!/bin/sh
### ====================================================================== ###
##                                                                          ##
##  Serviio start Script                                                    ##
##                                                                          ##
### ====================================================================== ###

SERVIIO_HOME=/usr/local/etc/serviio
SERVIIO_CLASS_PATH="$SERVIIO_HOME/lib/*:$SERVIIO_HOME/plugins/*:$SERVIIO_HOME/config"


# Find the best max heap size for JAVA ( From kairoh's serviio-webui
# scripts - https://kairo.bitbucket.org/serviio-webui, who references
# Platter's (http://pcloadletter.co.uk/2012/01.15/serviio-syno-paackages
JAVA_MAX_HEAP=512M
RAM=$(dmesg | grep 'real memory'| uniq | awk '{print $4/1048576}')
if [ $RAM -le 128 ]; then
    JAVA_MAX_HEAP=80M
elif [ $RAM -le 256 ]; then
    JAVA_MAX_HEAP=192M
fi

# Setup Serviio specific properties - might not need to specify ffmpeg
JAVA_OPTS="-Djava.net.preferIPv4Stack=true -Djava.awt.headless=true -Dderby.system.home=$SERVIIO_HOME/library -Dserviio.home=$SERVIIO_HOME -Dffmpeg.location=/usr/local/bin/ffmpeg1"
JVM_OPTS="-Xmx${JAVA_MAX_HEAP} -Xms20M -XX:+UseParNewGC -XX:MinHeapFreeRatio=10 -XX:MaxHeapFreeRatio=20"

# A kludge to get the -D... flags to Java, rather than to Serviio itself:
for o in "$@"
do
   case $o in
   -D*)
      JAVA_OPTS="$JAVA_OPTS $o"
      ;;
   esac
done

# Execute the JVM in the foreground
exec java $JVM_OPTS $JAVA_OPTS -classpath "$SERVIIO_CLASS_PATH" org.serviio.restui.ServiioWrapper "$@"

# Create a /usr/local/etc/rc.d/serviio file, and fill it with:
#!/bin/sh

# $FreeBSD: ports/net/serviio/files/serviio.in,v 1.2 2012/01/14 08:56:27 dougb Exp $
#
# PROVIDE: serviio
# REQUIRE: LOGIN
# KEYWORD: shutdown
#
# Add the following line to /etc/rc.conf[.local] to enable serviio:
#
# serviio_enable="YES"

. /etc/rc.subr

name=serviio
rcvar=serviio_enable
command=/usr/local/sbin/serviiod

load_rc_config $name

serviio_user=${serviio_user-"dlna"}

command_args=" &"

stop_cmd="$command -stop"

run_rc_command $1

# Make both files executable.
chmod +x /usr/local/sbin/serviiod
chmod +x /usr/local/etc/rc.d/serviio

# Enable serviio in your /etc/rc.conf file.
echo 'serviio_enable="YES"' >> /etc/rc.conf

# Now is time to add files/folders using serviio console, in my example: http://192.168.1.205:8123/serviio/console

# Serviio Logs
# First, you need to konw where is serviio.log file located:
# /mnt/NAS-A/Jail/serviio/usr/local/etc/serviio/log/serviio.log
# Now you need to edir rc.conf in Webgui to add a variable name "serviio_logfile" and use previos valua as data.

# Now How to add serviio.log to Nas4Free log:
First you need to edit file /usr/local/www/diag_log.inc use Advanced|File Editor to locate and load , so is ready to edit.

locate fuppes lines:

CODE: SELECT ALL
$fuppes_logfile = rc_getenv_ex("fuppes_logfile", "{$g['varlog_path']}/fuppes.log");


copy & paste & edit fuppes to minidlna like this:

CODE: SELECT ALL
$fuppes_logfile = rc_getenv_ex("fuppes_logfile", "{$g['varlog_path']}/fuppes.log");
$serviio_logfile = rc_getenv_ex("serviio_logfile", "{$g['varlog_path']}/serviio.log");



Find next fuppes section:

CODE: SELECT ALL
array(
      "visible" => TRUE,
      "desc" => gettext("fuppes"),
      "logfile" => $fuppes_logfile,
      "filename" => "fuppes.log",
      "type" => "plain",
      "pattern" => "/^(.*)$/",
      "columns" => array(
         array("title" => gettext("Event"), "class" => "listlr", "param" => "", "pmid" => 1)
      )),



Do the same , copy & paste and edit copy to sustitute fuppes by serviio

CODE: SELECT ALL
array(
      "visible" => TRUE,
      "desc" => gettext("DLNA"),
      "logfile" => $fuppes_logfile,
      "filename" => "fuppes.log",
      "type" => "plain",
      "pattern" => "/^(.*)$/",
      "columns" => array(
         array("title" => gettext("Event"), "class" => "listlr", "param" => "", "pmid" => 1)
      )),
array(
      "visible" => TRUE,
      "desc" => gettext("serviio"),
      "logfile" => $serviio_logfile,
      "filename" => "serviio.log",
      "type" => "plain",
      "pattern" => "/^(.*)$/",
      "columns" => array(
         array("title" => gettext("Event"), "class" => "listlr", "param" => "", "pmid" => 1)
      )),



save and test, go to Diagnostics|Log and select the new serviio log.

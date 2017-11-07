#------------------------------------------------------------------------------#
### CLOUD - ENABLE MEMORY CACHING
#TODO: Add option for automatic or manual (Will also need to ask if user is
#      using default installation folder otherwise the auto version won't work)
#------------------------------------------------------------------------------#

owncloud.enablememcache ()
{

while [ "$choice" ]
do
        echo "  'memcache.local' => '\OC\Memcache\APCu'," >> /usr/local/www/owncloud/config/memcache.txt
        cp /usr/local/www/owncloud/config/config.php /usr/local/www/owncloud/config/old_config.bak
        cat "/usr/local/www/owncloud/config/old_config.bak" | \
	        sed '21r /usr/local/www/owncloud/config/memcache.txt' > \
            "/usr/local/www/owncloud/config/config.php"
        rm /usr/local/www/owncloud/config/memcache.txt

        /usr/local/etc/rc.d/lighttpd restart

        echo " "
        echo "${sep}"
        echo " "

        echo -e " Head to your owncloud admin page/refresh it"
        echo -e " There should no longer be a message at the top about memory caching"
        echo -e " If it didn't work follow these steps:"
        echo -e " "
        echo -e "${msg} This is entirely optional. Edit config.php:${nc}"
        echo -e "${msg} Default location is:${nc}"
        echo -e "\033[1;36m    /usr/local/www/owncloud/config/config.php${nc}"
        echo -e "${msg} Add the following right above the last line:${nc}"
        echo -e "\033[1;33m    'memcache.local' => '\OC\Memcache\APCu',${nc}"
        echo " "
        echo -e "${msg} Once you've saved the file, restart the server with:${nc}"
        echo -e "${cmd}    /usr/local/etc/rc.d/lighttpd restart"
        echo " "
        echo -e "${emp}   Press Enter To Go Back To The Menu${nc}"
        echo -e "${msep}"

        read choice

        case $choice in
            *)
                 return
                 ;;
        esac
done
}

owncloud.enablememcache

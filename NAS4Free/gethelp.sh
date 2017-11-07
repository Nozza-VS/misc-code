################################################################################
##### CONTACT
################################################################################

while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} Ways of contacting me / Getting help from others:${nc}"
        echo -e "${sep}"
        echo " "
        echo -e "${fin}   ${ul}My Discord Support${fin} (Usually faster responses):${nc}"
        echo -e "${msg}      https://discord.gg/0bXnhqvo189oM8Cr${nc}"
        echo -e "${fin}   ${ul}My Email${fin} (Discord is easier):${nc}"
        echo -e "${msg}      support@vengefulsyndicate.com${nc}"
        echo -e "${fin}   ${ul}Forums:${nc}"
        echo -e "${msg}      NAS4Free Forums - NextCloud/OwnCloud:${nc}"
        echo -e "${url}      http://forums.nas4free.org/viewtopic.php?f=79&t=9383${nc}"
        echo -e "${msg}      [VS] Forums:${nc}"
        echo -e "${url}      forums.vengefulsyndicate.com${nc}"
        echo " "
        echo -e "${fin}   Find an issue with the script or have a suggestion?${nc}"
        echo -e "${msg}   Drop a message using the above or head here:${nc}"
        echo -e "${url}      https://github.com/Nostalgist92/misc-code/issues"
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

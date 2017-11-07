#------------------------------------------------------------------------------#
### EMBY SERVER SUBMENU

emby.submenu ()
{
while [ "$choice" != "a,h,i,b,q" ]
do
        echo -e "${sep}"
        echo -e "${fin} Emby Options${nc}"
        echo -e "${sep}"
        echo -e "${qry} Choose one:${nc}"
        echo " "
        echo -e "${fin}   1)${msg} Install${nc}"
        echo -e "${fin}   2)${msg} Update${nc}"
        echo -e "${fin}   3)${msg} Backup${nc}"
        echo " "
        echo -e "${fin}   4)${msg} Increase server performance${nc}"
        echo -e "${fin}   5)${msg} Enable more transcoding options${nc}"
        echo " "
        echo -e "${ca}  a) About Emby${nc}"
        echo -e "${ca}  i) More Info / How-To's (Currently Unavailable)${nc}"
        echo -e "${ca}  h) Get Help${nc}"
        echo " "
        echo -e "${emp}  b) Back${nc}"

        echo -e "${ssep}"
        read -r -p "     Your choice: " choice
        echo -e "${ssep}"
        echo " "

        case $choice in
            '1')	printf '\033\143'; echo -e "${inf} Installing..${nc}" ; echo " "
					. $scriptPath/Streaming/Emby/install.sh ;;
            '2')	printf '\033\143'; echo -e "${inf} Running Update..${nc}" ; echo " "
                	. $scriptPath/Streaming/Emby/update.sh ;;
            '3')	printf '\033\143'; echo -e "${inf} ..${nc}" ; echo " "
					. $scriptPath/Streaming/Emby/backup.sh ;;
            '4')	printf '\033\143'; echo -e "${inf} ..${nc}" ; echo " "
                	. $scriptPath/Streaming/Emby/recompile.imagemagick.sh ;;
            '5')	printf '\033\143'; echo -e "${inf} ..${nc}" ; echo " "
                	. $scriptPath/Streaming/Emby/recompile.ffmpeg.sh ;;

            'a')	printf '\033\143'; . $scriptPath/Streaming/Emby/about.sh ;;
            'h')	printf '\033\143'; (. $scriptPath/gethelp.sh);;
            'i')	printf '\033\143'; . $scriptPath/Streaming/Emby/moreinfo.sh ;;

            'b') 	printf '\033\143'; return ;;
			'm') 	. $scriptPath/mainmenu.sh ;;

            *)		echo -e "${alt}        Invalid choice, please try again${nc}" ; echo " " ;;
        esac
done
}

emby.submenu

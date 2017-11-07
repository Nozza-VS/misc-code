#------------------------------------------------------------------------------#
### ABOUT: SUBSONIC

about.subsonic ()
{
while [ "$choice" ]
do
        echo -e "${sep}"
        echo -e "${inf} About: Subsonic${nc}"
        echo " "
        echo -e "${msg} Subsonic is a free, web-based media streamer, providing ubiqutious access${nc}"
        echo -e "${msg} to your music. Use it to share your music with friends, or to listen to your${nc}"
        echo -e "${msg} own music while at work. You can stream to multiple players simultaneously,${nc}"
        echo -e "${msg} for instance to one player in your kitchen and another in your living room.${nc}"
        echo " "
        echo -e "${msg} Subsonic is designed to handle very large music collections${nc}"
        echo -e "${msg} (hundreds of gigabytes). Although optimized for MP3 streaming, it works for any${nc}"
        echo -e "${msg} audio or video format that can stream over HTTP, for instance AAC and OGG.${nc}"
        echo -e "${msg} By using transcoder plug-ins, Subsonic supports on-the-fly conversion and${nc}"
        echo -e "${msg} streaming of virtually any audio format, including WMA, FLAC, APE, Musepack,${nc}"
        echo -e "${msg} WavPack and Shorten.${nc}"
        echo -e "${sep}"
        echo " "

        echo -e "${msep}"
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

about.subsonic

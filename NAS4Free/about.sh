#------------------------------------------------------------------------------#
### ABOUT: THIS SCRIPT

while [ "$choice" ]
do
	echo -e "${sep}"
    echo -e "${inf} About: This Script${nc}"
    echo " "
	echo -e "${msg} I've been maintaining the 'OwnCloud in a Jail' NAS4Free script${nc}"
	echo -e "${msg} for some time now and I tend to do a lot of messing around in jails on NAS4Free${nc}"
	echo -e "${msg} As well as helping others set up jails for different things.${nc}"
	echo " "
	echo -e "${msg} So I figured, 'why am i always manually doing all this when i can script it?'${nc}"
	echo -e "${msg} And now here we are! Aiming to have a mostly automated script for some of the${nc}"
	echo -e "${msg} most common jail setups and hopefully some useful info about these setups${nc}"
	echo -e "${msg} to help aid with any possible issues without google search frenzies!${nc}"
	echo " "
	echo -e "${msg} Wish to contribute? Feel free to drop me a message anyhere listed in the${nc}"
	echo -e "${msg} 'Contact / Get Help' menu.${nc}"
	echo " "
	echo -e "${msg} Like my work enough to buy me a pizza? Please do!${nc}"
	echo -e "${url} https://www.paypal.me/AshleyTownsend${nc}"
	echo -e "${sep}"
	echo " "

	echo -e "${msep}"
	echo -e "${emp}   Press Enter To Go Back To The Menu${nc}"
	echo -e "${msep}"

	read choice

	case $choice in
    	*)	return ;;
esac
done

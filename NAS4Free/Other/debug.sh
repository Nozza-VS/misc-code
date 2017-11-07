################################################################################
##### Debug
################################################################################

OPTIND=1         # Reset in case getopts has been used previously in the shell.

while getopts "dnvh" opt; do
      case $opt in
        h)	echo " "
			echo -e "${inf} -v ${msg}Run the script run in verbose mode${nc}"
			echo -e "${inf} -d ${msg}Print command traces before executing command${nc}"
			echo -e "${inf} -n ${msg}Read commands but do not execute them${nc}"
			echo " "
			exit 1;;
        d)	set -x;;
        n)	set -n;;
        v)	set -v;;
        *)  echo " "
			echo -e "${alt}        Invalid choice, please try again${nc}"
			echo " "
            exit 1;;

      esac
    done

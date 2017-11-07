#!/bin/sh
#[ -n "$DEBUG" ] && set -x -o pipefail -e
# AIO Script                    Version: 1.00 (May 19, 2017)
# By Ashley Townsend (Nozza)    Copyright: Beerware License
################################################################################

cd $scriptPath
echo "$scriptPath"
cd ../..
git clone https://github.com/Nostalgist92/misc-code.git
echo " Done with update, now re-run the 'mainmenu.sh'"
exit

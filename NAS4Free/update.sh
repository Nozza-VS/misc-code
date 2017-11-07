#!/bin/sh
#[ -n "$DEBUG" ] && set -x -o pipefail -e
# AIO Script                    Version: 1.00 (May 19, 2017)
# By Ashley Townsend (Nozza)    Copyright: Beerware License
################################################################################

PKG_OK=$(pkg query %n git-lite|grep "git-lite")
#Check to see if Git is installed
if [ "" == "$PKG_OK" ]; then
  echo "Git not installed, installing now."
  pkg install -y git-lite
fi

cd $scriptPath
gitdir="$(dirname "$dir")"
git fetch https://github.com/Nostalgist92/misc-code.git

echo " Done with update, now re-run the 'mainmenu.sh'"
echo "chmod +x $gitdir"
exit

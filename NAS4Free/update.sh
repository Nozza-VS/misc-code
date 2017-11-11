#!/bin/sh
#[ -n "$DEBUG" ] && set -x -o pipefail -e
# AIO Script                    Version: 1.00 (May 19, 2017)
# By Ashley Townsend (Nozza)    Copyright: Beerware License
################################################################################

#Check to see if Git is installed
PKG_OK=$(pkg info|grep -E "(\bgit\-lite-|\bgit-)")
if [ "" == "$PKG_OK" ]; then
  echo "Git not installed, installing now."
  pkg install -y git-lite
  else
  	echo "Git found, proceeding with fetch"
fi

# Make sure we are in the right dir
cd $scriptPath
gitdir="$(dirname "$scriptPath")"

# Fetch any updates
git fetch https://github.com/Nostalgist92/misc-code.git

# Ensure the main menu file is executable
chmod +x $gitdir/NAS4Free/mainmenu.sh

# Done!
echo " Done with update, now re-run $gitdir/NAS4Free/'mainmenu.sh'"
exit

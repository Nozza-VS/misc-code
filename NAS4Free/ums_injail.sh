#!/bin/sh
# Script Version: TESTING-1.0 (March 10, 2016)
#	Install script for UMS (UniversalMediaServer) in a jailed environment
#   See http://forums.nas4free.org/viewtopic.php?f=79&t=5221 for more info.
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

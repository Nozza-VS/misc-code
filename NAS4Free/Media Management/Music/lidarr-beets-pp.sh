#!/usr/bin/env python
#=============================================================================#
#== LIDARR POST-PROCESSING SCRIPT                                           ==#

# Script to run the import command of a beets docker container via ssh key.
#
# Configuration of beets is done in the beets container.
#
# NOTE: This script requires Python to be installed on your system.

#=============================================================================#
#== OPTIONS                                                                 ==#

# Docker user and beets docker host address
# Enter the ssh username and address of the docker host.
#sshuseraddress=root@192.168.1.2

# ssh password
# If not using a ssh key, enter your ssh user's password here.
#sshpassword=

# Use ssh key (yes,no).
# Activate if you want to connect to the beets docker using a ssh key.
#usesshkey=no

# ssh key location
# If using a ssh key, enter it's location here.
#sshkey=/config/.ssh/id_rsa

# Use ssh key paraphrase(yes,no).
# Activate if you used a paraphrase when setting up the ssh hosts ssh keys.
#useparaphrase=no

# ssh paraphrase
# If using a paraphrase, enter it here.
#paraphrase=

# Beets docker name
# Enter the host machines beets docker name.
#dockername=beets

# Location of music to import
# Location of music to import relative to the beets docker
#musiclocation=

#== LIDARR POST-PROCESSING SCRIPT                                           ==#
#=============================================================================#
import os
import sys
import subprocess

# LIDARR Exit Codes
LIDARR_POSTPROCESS_SUCCESS = 93

if os.environ.get('NZBPO_USESSHKEY') == 'yes':
	if os.environ.get('NZBPO_USEPARAPHRASE') == 'yes':
		# set the permissions of the ssh key
		subprocess.call(["chmod","600",os.environ.get('NZBPO_SSHKEY')])
		# execute the import command on the unRAID systems Linuxserver.io beets docker container
		subprocess.call(["ssh","-i",os.environ.get('NZBPO_SSHKEY'),"-o","StrictHostKeyChecking=no","-tt",os.environ.get('NZBPO_SSHUSERADDRESS'),"docker exec -i -t",os.environ.get('NZBPO_DOCKERNAME'),"beet import",os.environ.get('NZBPO_MUSICLOCATION')])
		# ssh key paraphrase
		subprocess.call([os.environ.get('NZBPO_PARAPHRASE')])
	else:
		# set the permissions of the ssh key
		subprocess.call(["chmod","600",os.environ.get('NZBPO_SSHKEY')])
		# execute the import command on the unRAID systems Linuxserver.io beets docker container
		subprocess.call(["ssh","-i",os.environ.get('NZBPO_SSHKEY'),"-o","StrictHostKeyChecking=no","-tt",os.environ.get('NZBPO_SSHUSERADDRESS'),"docker exec -i -t",os.environ.get('NZBPO_DOCKERNAME'),"beet import",os.environ.get('NZBPO_MUSICLOCATION')])

else:
	# execute the import command on the unRAID systems Linuxserver.io beets docker container
	subprocess.call(["ssh","-o","StrictHostKeyChecking=no","-tt",os.environ.get('NZBPO_SSHUSERADDRESS'),"docker exec -i -t",os.environ.get('NZBPO_DOCKERNAME'),"beet import",os.environ.get('NZBPO_MUSICLOCATION')])
	# ssh password
	subprocess.call([os.environ.get('NZBPO_SSHPASSWORD')])


# 93 is code for success
sys.exit(LIDARR_POSTPROCESS_SUCCESS)
#=============================================================================#
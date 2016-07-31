# Possible first steps:
mkdir ~/.ssh
ssh-keygen -f ~/.ssh/id_rsa -q -P ""
cat ~/.ssh/id_rsa.pub
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC9POnRlzqAkaJwZ4rJaxLjqpyDRCB4Gfz0+dQBdZ3OzNz+5y7FAQX9XwBvcl1UnpdwwsdBesCWheQQOOY/KFujwGZLDoyaNfSOv0+iUDoA1jwaoWNovRfxojG5taOu+2+u5kNuEFbb8PL0Msqf6WnMH4QQFrpjMlATbidwegIJjrhK9moiD7P3g+fRebOlT3wDNCvf7mgF9O4efROPHOcJoNvOQkuTE2I6dZ9/HwYX06RSGBa/xhH4K69ltqKSonSq1ZedKf67zL2qq3oVMDcuk5vkps+JmQyiy7QpCYykvs7ZrRnFZR5ucLSi8bKth7ZCaEFJpBWrIRlBPBB5YTwJ root@nas.local
# Copy above key in to the following file
chmod 0700 ~/.ssh
touch ~/.ssh/authorized_keys
chmod 0644 ~/.ssh/authorized_keys

# Now run the command:
rsync -avz -e "ssh -p 1309 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --info=progress2 /folder/to/sync user@remoteaddress.com:/folder/to/sync/to

rsync -az -e "ssh -p 1309 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --info=progress2 /mnt/Storage/Users/Col/ root@vengefulsyndicate.com:/mnt/Storage/User_Files/CJMchatton
rsync -az -e "ssh -p 1309 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --info=progress2 /mnt/Storage/Users/Sarah/ root@vengefulsyndicate.com:/mnt/Storage/User_Files/SJMchatton
rsync -az -e "ssh -p 1309 -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" --info=progress2 /mnt/Storage/Users/Kaye/ root@vengefulsyndicate.com:/mnt/Storage/User_Files/KMchatton

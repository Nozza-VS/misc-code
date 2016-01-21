# Backup Folder 1 to Folder 2
# Also exclude certain items.

rsync -a --progress --exclude-from '/mnt/Rsync_ExcludeList.txt'  /mnt/CopyFrom/Folder1/ /mnt/CopyTo/Folder2/
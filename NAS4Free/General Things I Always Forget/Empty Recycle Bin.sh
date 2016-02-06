# Purge Users Home Directory Recycle Bin of deleted files older than 7 days old.
find /mnt/usersparentdir/*/.recycle/* -atime +7 -exec rm -rf '{}' \;
find /mnt/usersparentdir/*/.recycle/ -depth -type d -empty -exec rmdir {} \;

# Purge exampledir2 Recycle Bin of deleted files older than 7 days old.
find /mnt/exampledir1/.recycle/* -atime +7 -exec rm -rf '{}' \;
find /mnt/exampledir1/.recycle/ -depth -type d -empty -exec rmdir {} \;

# Purge exampledir3 Recycle Bin of deleted files older than 7 days old.
find /mnt/exampledir2/.recycle/* -atime +7 -exec rm -rf '{}' \;
find /mnt/exampledir2/.recycle/ -depth -type d -empty -exec rmdir {} \;
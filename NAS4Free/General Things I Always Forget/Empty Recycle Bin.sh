# Purge Users Home Directory Recycle Bin of deleted files older than 7 days old.
find /mnt/Users/*/.recycle/* -atime +7 -exec rm -rf '{}' \;
find /mnt/Users/*/.recycle/ -depth -type d -empty -exec rmdir {} \;

# Purge Storage Share Recycle Bin of deleted files older than 7 days old.
find /mnt/Storage/.recycle/* -atime +7 -exec rm -rf '{}' \;
find /mnt/Storage/.recycle/ -depth -type d -empty -exec rmdir {} \;

# Purge Media Share Recycle Bin of deleted files older than 7 days old.
find /mnt/Media/.recycle/* -atime +7 -exec rm -rf '{}' \;
find /mnt/Media/.recycle/ -depth -type d -empty -exec rmdir {} \;
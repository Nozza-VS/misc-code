# Clean out a particular folder

# This is set to delete any file smaller than 50MB in size
find /mnt/foldername/cleanthisfolder -size +1 -a -size -50MB -exec rm -f {} \;

# This deletes any empty folders left behind.
find /mnt/foldername/cleanthisfolder -type d -empty -exec rmdir {} \;
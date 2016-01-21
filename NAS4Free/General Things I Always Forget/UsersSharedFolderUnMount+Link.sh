# Public Shares - Unmount these shared folders so they can no longer be accessed.
umount /mnt/Users/User1/"[Public Shares]"
umount /mnt/Users/User2/"[Public Shares]"
umount /mnt/Users/User3/"[Public Shares]"
umount /mnt/Users/User4/"[Public Shares]"
umount /mnt/Users/User5/"[Public Shares]"
umount /mnt/Users/Guest/"[Public Shares]"

# Private Shares - Unmount these shared folders so they can no longer be accessed.
umount /mnt/Users/User1/"[Private Shares]"
umount /mnt/Users/User4/"[Private Shares]"

# Remove folders that are meant to be linked to Public or Private shares
rmdir /mnt/Users/User1/"[Public Shares]"
rmdir /mnt/Users/User4/"[Private Shares]"
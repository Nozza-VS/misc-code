# Public Shares - Allow these users to access the Publicly shared folders.
mount_nullfs /mnt/Users/.Public /mnt/Users/User1/"[Public Shares]"
mount_nullfs /mnt/Users/.Public /mnt/Users/User3/"[Public Shares]"
mount_nullfs /mnt/Users/.Public /mnt/Users/User2/"[Public Shares]"
mount_nullfs /mnt/Users/.Public /mnt/Users/User4/"[Public Shares]"
mount_nullfs /mnt/Users/.Public /mnt/Users/User5/"[Public Shares]"
mount_nullfs /mnt/Users/.Public /mnt/Users/GuestUser/"[Public Shares]"

# Private Shares - Allow these users to access the Privately shared folder.
mount_nullfs /mnt/Users/.Private /mnt/Users/User1/"[Private Shares]"
mount_nullfs /mnt/Users/.Private /mnt/Users/User4/"[Private Shares]"
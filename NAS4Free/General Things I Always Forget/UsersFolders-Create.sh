# User 1 - Create this users directories
mkdir -p /mnt/Users/User1/"[Public Shares]"
mkdir -p /mnt/Users/User1/"[Private Shares]"

# User 2 - Create this users directories
mkdir -p /mnt/Users/User2/"[Public Shares]"
mkdir -p /mnt/Users/User2/UserFolder1
mkdir -p /mnt/Users/User2/UserFolder2
mkdir -p /mnt/Users/User2/UserFolder3

# User 3 - Create this users directories
mkdir -p /mnt/Users/User3/"[Public Shares]"
mkdir -p /mnt/Users/User3/UserFolder1
mkdir -p /mnt/Users/User3/UserFolder2
mkdir -p /mnt/Users/User3/UserFolder3

# User 4 - Create this users directories
mkdir -p /mnt/Users/User4/"[Public Shares]"
mkdir -p /mnt/Users/User4/UserFolder1
mkdir -p /mnt/Users/User4/UserFolder2
mkdir -p /mnt/Users/User4/UserFolder3

# User 5 - Create this users directories
mkdir -p /mnt/Users/User5/"[Public Shares]"
mkdir -p /mnt/Users/User5/UserFolder1
mkdir -p /mnt/Users/User5/UserFolder2
mkdir -p /mnt/Users/User5/UserFolder3

# Guest User - Create directories for guest users
mkdir -p /mnt/Users/GuestUserUser/"[Public Shares]"
mkdir -p /mnt/Users/GuestUser/UserFolder1
mkdir -p /mnt/Users/GuestUser/UserFolder2
mkdir -p /mnt/Users/GuestUser/UserFolder3

# Public & Private - Create Public folders to be shared with everyone
# - Create Private folders to be shared with select people.
mkdir -p /mnt/Users/.Public/UserFolder1
mkdir -p /mnt/Users/.Public/UserFolder2
mkdir -p /mnt/Users/.Public/UserFolder3
mkdir -p /mnt/Users/.Private

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
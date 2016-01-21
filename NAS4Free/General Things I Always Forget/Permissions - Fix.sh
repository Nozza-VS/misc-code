# Run Manually if and when needed

# Set ownership and permissions of: (chown = Owner & Group; chgrp = Group; chmod = Access Permissions)

# Media & Subdirectories
chown -R root:MediaWRITEGroup '/mnt/Media'
chmod -R 775 '/mnt/Media'

# Users & Subdirectories
chgrp 1000 '/mnt/Users'
chmod 770 '/mnt/Users'
chown -R 0:UsersGroup '/mnt/Users/.Private'
chmod -R 770 '/mnt/Users/.Private'
chown -R 0:UsersGroup '/mnt/Users/.Public'
chmod -R 777 '/mnt/Users/.Public'
chown -R 0:UsersGroup '/mnt/Users/Guest'
chmod -R 777 '/mnt/Users/Guest'

# OS Files (Setup Files/Drivers/Operating System ISO's etc.) & Subdirectories
chown -R root:SetupWRITEGroup '/mnt/Setup_Files'
chmod -R 775 '/mnt/Setup_Files'

# Backups & Subdirectories
chown -R root:BackupWRITEGroup '/mnt/Backups'
chmod -R 775 '/mnt/Backups'

# Completed Downloads & Subdirectories
chown -R root:DownloadWRITEGroup '/mnt/Downloads/Completed'
# chmod -R 775 '/mnt/Storage/Downloads/Completed'

# Web Server & Subdirectories
chown -R 80:80 '/mnt/Web.Server'
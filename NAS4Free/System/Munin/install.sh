###########################################################################################################################################

#!/bin/sh

jailid="Munin"
jailip="192\.168\.1\.250" # Keep the "\" only modify the numbers





pkg install -y munin-node nano

echo " edit the Munin-Node configuration file to allow Munin-Master to access it:"
nano /usr/local/etc/munin/munin-node.conf

echo "    allow ^127\.0\.0\.1$ "
echo "    allow ^::1$ "

echo " add:"
echo "    allow ^192\.168\.1\.251$ "

echo " save and exit the file"

echo " The next step is for Munin-Node to configure itself:"
/usr/local/sbin/munin-node-configure --shell | sh -x

# Start munin
/usr/local/etc/rc.d/munin-node onestart

# To ensure it starts everytime the host is restarted, add 'munin_node_enable="YES"' on the N4F GUI (System -> Advanced -> rc.conf)



# Now set up jail
jexec Munin csh

echo '192.168.1.3 nas nas.local' >> /etc/hosts
echo '192.168.1.250 munin munin.local' >> /etc/hosts

pkg install -y apache24 nano munin-master



echo 'apache24_enable="YES"' >> /etc/rc.conf



nano /usr/local/etc/munin/munin.conf

# Find this
# a simple host tree
[Munin.local]
    address 127.0.0.1
    use_node_name yes

# Add the following below
[nas.local]
    address 192.168.1.250
    use_node_name yes


touch /usr/local/etc/apache22/Includes/munin.conf
nano /usr/local/etc/apache22/Includes/munin.conf

# Add:
Alias /munin "/usr/local/www/munin"

<Directory /usr/local/www/munin>
Options none
AllowOverride Limit
Order Deny,Allow
Deny from all
Allow from all
</Directory>


rm -rf /usr/local/www/munin/.htaccess


/usr/local/etc/rc.d/apache24 configtest


/usr/local/etc/rc.d/apache24 start

#To test Munin, enter http://192.168.1.251/munin into your browser and the Overview page should show up.



mv /usr/local/www/munin/

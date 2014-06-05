#!/bin/bash

sudo su

# INITIAL APTITUDE CLEANING
apt-get update

# PUPPET
apt-get install puppet
puppet apply puppet/manifest.pp
 
# Only allow admin users to use su
#dpkg-statoverride --update --add root admin 4750 /bin/su
#ls -lh /bin/su
 
# SECURE SHARED MEMORY
#echo "tmpfs     /dev/shm     tmpfs     defaults,noexec,nosuid     0     0" | sudo tee -a /etc/fstab
 
# Denyhosts: avoid SSH attacks
#apt-get install -y denyhosts
#touch /etc/hosts.deny
#touch /etc/hosts.allow
#echo "ADMIN_EMAIL = info@fabiocicerchia.it" | tee -a /etc/denyhosts.conf
#service denyhosts restart
 
# Prevent IP Spoofing.
#echo "order bind,hosts\nnospoof on" | tee -a /etc/host.conf
 
# UPDATE SOFTWARE PACKAGES
apt-get update
apt-get upgrade
apt-get autoremove
apt-get autoclean
apt-get clean 

exit

cp utils/login.sh cp ~/
cp utils/monitor_temp.sh cp ~/
cp utils/temp.sh cp ~/
cp utils/boot.sh cp ~/
cp configs/.screenrc cp ~/
cp configs/.bashrc cp ~/

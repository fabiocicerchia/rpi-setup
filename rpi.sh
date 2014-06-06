#!/bin/bash

# PUPPET
sudo apt-get install puppet
sudo puppet apply puppet/manifest.pp
 
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
sudo apt-get update
sudo apt-get upgrade
sudo apt-get autoremove
sudo apt-get autoclean
sudo apt-get clean 

cp utils/login.sh ~/
cp utils/monitor_temp.sh ~/
cp utils/temp.sh ~/
cp utils/boot.sh ~/
cp configs/.screenrc ~/
cp configs/.bashrc ~/

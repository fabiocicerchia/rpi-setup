IP_INT=`ifconfig wlan0 | grep "inet addr" | awk -F: '{print $2}' | awk '{print $1}'`
IP_EXT=`wget -qO- http://ipecho.net/plain ; echo`
echo "RPI boot up at $(date). IP: $IP_INT / $IP_EXT" | sudo mail -s "RPI - Boot" "<email@address>" &

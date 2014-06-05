ip=`echo $SSH_CONNECTION | cut -d " " -f 1`
logger -t ssh-wrapper $USER login from $ip
echo "User $USER just logged in from $ip at $(date)" | sudo mail -s "RPI - SSH Login - $USER" "<email@address>" &

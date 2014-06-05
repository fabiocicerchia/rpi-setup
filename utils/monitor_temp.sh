#!/bin/sh

HIGH=70
SHUTDOWN_TEMP=85
export HIGH
export SHUTDOWN_TEMP

while true; do
    # read temp
    TEMP=`/home/phakko/temp.sh | grep 'CPU Temp' | cut -d= -f2 | cut -d. -f1`

    if [ "$TEMP" -gt "$HIGH" ]; then
        echo "High temp: $TEMP > $HIGH" | wall
        sleep 2
    else
        if [ "$TEMP" -gt "$SHUTDOWN_TEMP" ]; then
            MSG="Too hot ($TEMP), shutting down in 30 secs! (Run shutdown -c to abort)"
            echo $MSG | wall
            echo $MSG | sudo mail -s "RPI - Too Hot - $TEMP" "<email@address>" &
            sleep 30
            sudo shutdown now
        else
            echo "temp OK: $TEMP"
            sleep 5
        fi
    fi
done

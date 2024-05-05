#!/bin/bash

DISK_USAGE=$(df -hT | grep -i xfs)
DISK_THRESHOLD=5

while IFS= read -r line
do 
    USAGE=$(echo $line | awk -F " " '{print $6F}' | cut -d "%" -f1 )
    FOLDER=$(echo $line | awk -F " " '{print $6F}')
    if [ $USAGE -ge $DISK_THRESHOLD ]
    then
        echo "$FOLDER is is greater then $DISK_THRESHOLD. Current usage is :$USAGE"
    fi
done <<<$DISK_USAGE

#!/bin/bash

DISK_USAGE=$(df -hT | grep -i xfs)
DISK_THRESHOLD=5
MESSAGE=""

while IFS= read -r line
do 
    USAGE=$(echo $line | awk -F " " '{print $6F}' | cut -d "%" -f1 )
    FOLDER=$(echo $line | awk -F " " '{print $7F}')
    if [ $USAGE -ge $DISK_THRESHOLD ]
    then
        MESSAGE+="$FOLDER is is greater then $DISK_THRESHOLD. Current usage is :$USAGE"
    fi
done <<<$DISK_USAGE

echo "message: $MESSAGE"

#!/bin/bash

DIRECTORY=/tmp/loki-logs

if [ -d "$DIRECTORY" ]; then
  echo "$DIRECTORY does exist."
else 
    echo "$DIRECTORY doesn't exist"
fi

FILES=$(find $DIRECTORY -name "*.log" -mtime +9)

echo "/n Files to delete $FILES"


#IFS=internel field separator, helps to sepearate lines
while IFS = read -r line
do 
    echo "Deleting files $line"
done <<<$FILES

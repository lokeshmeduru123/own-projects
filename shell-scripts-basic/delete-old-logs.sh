#!/bin/bash

SOURCE_DIRECTORY=/var/log/

if  [ -d SOURCE_DIRECTORY ]
then
    echo "source directory exists"
else
    echo "source directry not present"
    exit 1
fi

FILES=$("find /var/log/ -name "*.log" -mtime -7")

while IFS = read -r line
do 
    echo "Deleting the file $line"
    rm -rf $line
done  <<< $FILES


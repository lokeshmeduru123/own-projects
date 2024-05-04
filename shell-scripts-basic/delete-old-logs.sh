#!/bin/bash

source_directory=/var/log

if  [ -d source_directory ]
then
    echo "source directory exists"
else
    echo "SOURCE DIRECTORY NOT PRESENT"
    exit 1
fi

FILES=$("find $source_directory -name "*.log" -mtime -7")

while IFS = read -r line
do 
    echo "Deleting the file $line"
    rm -rf $line
done  <<< $FILES


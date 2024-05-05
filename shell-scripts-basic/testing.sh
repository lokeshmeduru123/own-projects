#!/bin/bash

DIRECTORY=/home/ec2-user/app

if [ -d "$DIRECTORY" ]; then
  echo "$DIRECTORY does exist."
else 
    echo "$DIRECTORY doesn't exist"
fi

FILES=$(find $DIRECTORY -name "*.txt")

echo "Files to ZIP $FILES"


#IFS=internel field separator, helps to sepearate lines
while IFS= read -r file
do 
    echo "Zippping $file"
    gzip $file
done <<<$FILES
#!/bin/bash

DIRECTORY=/app

if [ -d "$DIRECTORY" ]; then
  echo "$DIRECTORY does exist."
else 
    echo "$DIRECTORY doesn't exist"
fi

FILES=$(find $DIRECTORY -name "*.txt")

echo "Files to ZIP $FILES"


#IFS=internel field separator, helps to sepearate lines
while IFS= read -r line
do 
    echo "Zippping $line"
    gzip $line
done <<<$FILES
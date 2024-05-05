#!/bin/bash

DIRECTORY=/home/ec2-user/app
DESTINATION=/home/ec2-user/external

if [ -d "$DIRECTORY" ]; then
  echo "$DIRECTORY does exist."
else 
    echo "$DIRECTORY doesn't exist"
fi

FILES=$(find $DIRECTORY -name "*.txt")

echo "Files to ZIP $FILES"


#IFS=internel field separator, helps to sepearate lines
while IFS= read -r file; do
    echo "Zipping $file"
    gzip "$file" && mv "$file.gz" "$DESTINATION"
    if [ $? -ne 0 ]; then
        echo "Error occurred while zipping or moving file."
        exit 1
    else
        echo "Moving the gzipped file to destination directory."
    fi
done <<< "$FILES"

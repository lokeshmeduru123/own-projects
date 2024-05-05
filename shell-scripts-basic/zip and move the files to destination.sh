#!/bin/bash
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"
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
        echo -e "$R No FILES TO ZIP.$N"
        exit 1
    else
        echo -e "$G Moving the gzipped file to destination directory.$N"
    fi
done <<< "$FILES"

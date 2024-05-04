#!/bin/bash

SOURCE_DIRECTORY="/var/log/"
file=("find /var/log/ -name "*.log" -mtime -7")

rm -rf $file
Echo "deleting $file "


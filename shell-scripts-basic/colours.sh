#!/bin/bash

echo "To get the text in colours"

# Below are the syntax for clours
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"

echo -e "$R FAILURE $N"
echo -e "$G SUCESS $N"
echo -e "$Y PENDING $N"
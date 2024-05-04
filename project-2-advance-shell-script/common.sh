#!/bin/bash
#to get the user id of the server , if user id is 0 then its a root user else its not a root user
set -e
#set -e helps to exit the script if error occurs
USERID=$(id -u)
Failure(){
    echo "error in $1, command: $2"
}
trap 'Failure ${LINENO} $BASH_COMMAND' ERR

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$(echo $0 | cut -d '.' -f1)
LOGFILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"




VALIDATE(){
    if [ $1 -ne 0 ]
    then 
        echo -e "$2...$R FAILURE $N"
        exit 1
    else
        echo -e "$2...$G SUCESS $N"
    fi
}

check_root(){
if [ $USERID -ne 0 ]
then 
    echo "please run the script with root access"
    exit 1 # manually exit if error occurs
else
    echo "you are a super user"
fi    
}

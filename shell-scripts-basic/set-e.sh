#!/bin/bash
set -e
#set -e helps to exit the script if error occurs
USERID=$(id -u)
Failure(){
    echo "error in $1, command $2"
}
trap 'Failure ${LINENO} $BASH_COMMAND' ERR

if [ $USERID -ne 0 ]
then 
    echo "please run the script with root access"
    exit 1 # manually exit if error occurs
else
    echo "you are a super user"
fi    
dnf install mysqlkkk -y 
dnf install git -y
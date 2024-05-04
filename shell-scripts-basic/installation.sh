#!/bin/bash
#to get the user id of the server , if user id is 0 then its a root user else its not a root user
USERID=$(id -u)

if [ $USERID -ne 0 ]
then 
    echo "please run the script with root access"
    exit 1 # manually exit if error occurs
else
    echo "you are a super user"
fi    
dnf install mysql -y 
if [ $? -ne 0 ]
then 
    echo "installation of mysql is failure"
        exit 1
else
    echo "insatallation of mysql is sucess"        
fi              

dnf install git -y &>>$LOGFILE
if [ $? -ne 0 ]
then 
    echo "installation of git is failure"
        exit 1
else
    echo "insatallation of git is sucess"        
fi  
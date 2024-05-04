#!/bin/bash
#to get the user id of the server , if user id is 0 then its a root user else its not a root user
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

if [ $USERID -ne 0 ]
then 
    echo "please run the script with root access"
    exit 1 # manually exit if error occurs
else
    echo "you are a super user"
fi    


dnf install nginx -y  &>>$LOGFILE
VALIDATE $? "Installing Nginx"

systemctl enable nginx &>>$LOGFILE
systemctl start nginx &>>$LOGFILE
VALIDATE $? "Enabling and staring Nginx"

rm -rf /usr/share/nginx/html/* &>>$LOGFILE
curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE
VALIDATE $? "Downloading html code"


cd /usr/share/nginx/html &>>$LOGFILE
unzip /tmp/frontend.zip &>>$LOGFILE
VALIDATE $? "unzipping html code"

cp /home/ec2-user/new-1/test/project/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
VALIDATE $? "Copying expense configaration"


#sometime we don't know if servie is in failed state or active state so we can use below command to fix
#systemctl is-active --quite servicename
systemctl restart nginx &>>$LOGFILE
VALIDATE $? "Restarting Nginixn"





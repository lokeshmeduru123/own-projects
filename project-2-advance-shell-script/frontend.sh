#!/bin/bash

source ./common.sh
check_root


dnf install nginx -y  &>>$LOGFILE

systemctl enable nginx &>>$LOGFILE
systemctl start nginx &>>$LOGFILE

rm -rf /usr/share/nginx/html/* &>>$LOGFILE
curl -o /tmp/frontend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-frontend-v2.zip &>>$LOGFILE

cd /usr/share/nginx/html &>>$LOGFILE
unzip /tmp/frontend.zip &>>$LOGFILE

cp /home/ec2-user/new-1/test/project/expense.conf /etc/nginx/default.d/expense.conf &>>$LOGFILE
VALIDATE $? "Copying expense configaration"


#sometime we don't know if servie is in failed state or active state so we can use below command to fix
#systemctl is-active --quite servicename
systemctl restart nginx &>>$LOGFILE






#!/bin/bash

source ./common.sh
check_root

echo "Please enter your MYSQL-DB passwrod"
read -s mysql_root_password
dnf module disable nodejs -y &>>$LOGFILE
dnf module enable nodejs:20 -y &>>$LOGFILE
dnf install nodejs -y &>>$LOGFILE
id expense
if [ $? -ne 0 ]
then 
useradd expense &>>$LOGFILE
else
    echo -e "expence user already exists...$Y skipping $N"
fi
mkdir -p /app &>>$LOGFILE
curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE
cd /app &>>$LOGFILE
rm -rf /app/*
unzip /tmp/backend.zip &>>$LOGFILE
cd /app &>>$LOGFILE
npm install &>>$LOGFILE
cp /home/ec2-user/new-1/test/project/backend.service  /etc/systemd/system/backend.service &>>$LOGFILE
systemctl daemon-reload &>>$LOGFILE
systemctl start backend &>>$LOGFILE
systemctl enable backend &>>$LOGFILE
dnf install mysql -y &>>$LOGFILE
# to idendty the idompotency 
#mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pExpenseApp@1 < /app/schema/backend.sql
mysql -h db.devops-project.site -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOGFILE
systemctl restart backend &>>$LOGFILE





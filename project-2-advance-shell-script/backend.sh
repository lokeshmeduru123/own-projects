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
echo "Please enter your MYSQL-DB passwrod"
read -s mysql_root_password

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


dnf module disable nodejs -y &>>$LOGFILE
VALIDATE $? "Disabling default nodejs"

dnf module enable nodejs:20 -y &>>$LOGFILE
VALIDATE $? "Enabling Nodejs version:20"

dnf install nodejs -y &>>$LOGFILE
VALIDATE $? "installing node js"


id expense
if [ $? -ne 0 ]
then 
useradd expense &>>$LOGFILE
VALIDATE $? "Creating expence user"
else
    echo -e "expence user already exists...$Y skipping $N"
fi

mkdir -p /app &>>$LOGFILE
VALIDATE $? "Creating app directory"

curl -o /tmp/backend.zip https://expense-builds.s3.us-east-1.amazonaws.com/expense-backend-v2.zip &>>$LOGFILE
VALIDATE $? "Downloading the code"

cd /app &>>$LOGFILE
rm -rf /app/*
unzip /tmp/backend.zip &>>$LOGFILE
VALIDATE $? "Extracting code"

cd /app &>>$LOGFILE
npm install &>>$LOGFILE
VALIDATE $? "Installing dependecies"

cp /home/ec2-user/new-1/test/project/backend.service  /etc/systemd/system/backend.service &>>$LOGFILE
VALIDATE $? "Copy backend.service file"

systemctl daemon-reload &>>$LOGFILE
systemctl start backend &>>$LOGFILE
systemctl enable backend &>>$LOGFILE
VALIDATE $? "Staring & enabled backend service"

dnf install mysql -y &>>$LOGFILE
VALIDATE $? "installing mysql client"

# to idendty the idompotency 
#mysql -h <MYSQL-SERVER-IPADDRESS> -uroot -pExpenseApp@1 < /app/schema/backend.sql

mysql -h db.devops-project.site -uroot -p${mysql_root_password} < /app/schema/backend.sql &>>$LOGFILE
VALIDATE $? "Schema Loading"

systemctl restart backend &>>$LOGFILE
VALIDATE $? "Restarting backend.servcie"




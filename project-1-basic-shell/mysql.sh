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


dnf install mysql-server -y &>>$LOGFILE
VALIDATE $? "installing mysql server"

systemctl enable mysqld &>>$LOGFILE
VALIDATE $? "Enabling mysql server"

systemctl start mysqld &>>$LOGFILE
VALIDATE $? "Starting mysql"


#below code is userd for idempotemcy
# mysql_secure_installation --set-root-pass ExpenseApp@1 
# VALIDATE $? "Setting up root password"

 mysql -h db.devops-project.site -uroot -p${mysql_root_password} -e 'SHOW DATABASES;' &>>$LOGFILE
 if [ $? -ne 0 ]
 then 
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOGFILE
    VALIDATE $? "setting up mqsql root password"
else
    echo -e "mysql Root password already set up...$Y Skipping $N"
fi




#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

USER_ID=$(id -u)
if [ $USER_ID -ne 0 ]; then
	echo  -e "$R You are not the root user, you dont have permissions to run this $N"
	exit 1
fi

VALIDATE(){
	if [ $1 -ne 0 ]; then
		echo -e "$2 ... $R FAILED $N"
		exit 1
	else
		echo -e "$2 ... $G SUCCESS $N"
	fi

}

yum update  -y
VALIDATE $? "Updating packages"

amazon-linux-extras install docker -y
VALIDATE $? "Installing Docker"

service docker start
VALIDATE $? "Starting Docker"

systemctl enable docker
VALIDATE $? "Enabling Docker"

usermod -a -G docker ec2-user
VALIDATE $? "Added ec2-user to docker group"

echo  -e "$R You need logout and login to the server $N"


#!/bin/bash

source components/common.sh

OS_PREREQ

Head "Install java"
apt-get install openjdk-8-jdk -y  &>>$LOG
Stat $?

Head "Install maven"
apt install maven -y &>>$LOG
Stat $?


DOWNLOAD_COMPONENT

Head "Extract Downloaded Archive"
cd /home/ubuntu && rm -rf user && unzip -o /tmp/user.zip &>>$LOG && mv user-main user  && cd user && mvn clean package &>>$LOG && mv target/users-api-0.0.1.jar user.jar
Stat $?



Head "Setup SystemD Service"
mv /home/ubuntu/user/systemd.service /etc/systemd/system/user.service && systemctl daemon-reload && systemctl start user && systemctl enable user &>>$LOG
Stat $?

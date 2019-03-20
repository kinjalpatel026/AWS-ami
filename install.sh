#!/usr/bin/env bash

yum install java-1.8.0-openjdk.x86_64 -y
yum install -y wget
cd /tmp
sudo wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
sudo rpm -ivh mysql57-community-release-el7-9.noarch.rpm
yum install -y mysql-server
yum install -y mysql
yum install -y maven
systemctl start mysqld
yum -y update
yum install -y ruby
wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
sudo chmod +x ./install
./install auto
service codedeploy-agent status
service codedeploy-agent start
service codedeploy-agent status


sleep 10
mkdir /opt/tomcat
wget -q --no-cookies -S "http://www.trieuvan.com/apache/tomcat/tomcat-9/v9.0.17/bin/apache-tomcat-9.0.17.tar.gz"
tar -xf apache-tomcat-9.0.16.tar.gz
sudo mv apache-tomcat-9.0.16/ /opt/tomcat/
sudo chmod 777 ~/.bashrc
echo "export CATALINA_HOME='/opt/tomcat/apache-tomcat-9.0.16/'" >> ~/.bashrc
sudo useradd -r tomcat --shell /bin/false
sudo chown -R tomcat:tomcat /opt/tomcat/
echo # Download Agent"
wget https://s3.amazonaws.com/amazoncloudwatch-agent/centos/amd64/latest/amazon-cloudwatch-agent.rpm
echo # Install Package
rpm -U ./amazon-cloudwatch-agent.rpm
systemctl daemon-reload
systemctl start cloudwatch.service
systemctl enable cloudwatch.service
cat > /etc/systemd/system/tomcat.service << EOF
[Unit]
Description= Tomcat 9
After=syslog.target network.target
[Service]
User=tomcat
Group=tomcat
Type=forking
Environment=JAVA_HOME=/usr/lib/jvm/jre-1.8.0-openjdk
Environment=CATALINA_PID=/opt/tomcat/apache-tomcat-9.0.16/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat/apache-tomcat-9.0.16
Environment=CATALINA_BASE=/opt/tomcat/apache-tomcat-9.0.16
Environment='JAVA_OPTS=-Djava.awt.headless=true -Djava.security.egd:/dev/./urandom'
ExecStart=/opt/tomcat/apache-tomcat-9.0.16/bin/startup.sh
EOF
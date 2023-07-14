#!/bin/bash

sudo apt-get update -y 
sudo apt update -y 
sudo apt install unzip
sudo apt install maven -y

# install aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

cd /root/
# Get binaries from S3
aws s3 cp s3://java-test-pro-buck/springboot-master/ . --recursive

chmod +x mvnw

# build mvn
./mvnw -Dmaven.test.failure.ignore=true clean package


# systemd service

# Create a systemd service file
SERVICE_FILE="/etc/systemd/system/mvntest.service"

# Create the systemd service file
cat << EOF > $SERVICE_FILE
[Unit]
Description=My Service
After=network.target

[Service]
ExecStart=/bin/bash -c "java -jar /root/target/demo-0.0.1-SNAPSHOT.jar >> /root/output.log"
WorkingDirectory=/root
Restart=always

[Install]
WantedBy=default.target
EOF


# Reload the systemd daemon to read the new service file
systemctl daemon-reload -y

# Enable and start the service
systemctl enable mvntest.service
systemctl start mvntest.service
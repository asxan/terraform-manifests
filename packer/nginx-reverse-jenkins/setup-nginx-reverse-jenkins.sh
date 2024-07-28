#!/bin/bash
# Set up Nginx Reverse Jenkins proxy
# This script sets up nginx for reversing traffic to Jenkins Host
# Created by Vitalii Klymov 06/04/2024

#set -e

echo "Install packages updates"
sudo yum update -y
echo "Enable epel-release repository"
sudo yum install -y  epel-release

echo "Install Nginx"
sudo yum install -y  nginx

echo "Copy certificates and nginx config file"
if [[ -e /tmp/easyio.asxan.fun.tar.gz ]]; then
  sudo mkdir /etc/nginx/ssl
  sudo tar -xf /tmp/easyio.asxan.fun.tar.gz -C /tmp/
  sudo cp -r /tmp/easyio.asxan.fun/fullchain.pem /etc/nginx/ssl/fullchain.pem
  sudo cp -r /tmp/easyio.asxan.fun/privkey.pem /etc/nginx/ssl/privkey.pem
else
    exit
fi

if [[ -e /tmp/jenkins.conf ]]; then
  sudo cp -r /tmp/jenkins.conf /etc/nginx/conf.d/
else
    exit
fi

echo "Removing files from /tmp"
sudo rm -rf /tmp/*

echo "Start nginx"
sudo systemctl start nginx
#sudo systemctl status nginx.service
#sudo journalctl -xeu nginx.service

sudo systemctl enable nginx
sudo systemctl status nginx

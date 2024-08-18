#!/bin/bash
# Script for nginx installation to check the Internal IP address of VM
# Created by Vitalii Klymov
# 08/03/2024. Changed 08/18/2024


set -e

# Function ti install and configure nginx
#
function install_nginx() {
    local package_manager=$1
    local web_root=$2
    local rc_local_path="/etc/rc.d/rc.local"

    if sudo $package_manager list installed nginx > /dev/null 2>&1; then
        echo "Nginx is already  installed."
    else
        echo "Installing nginx..."
        sudo $package_manager install -y nginx
    fi

    if sudo $package_manager list installed nginx > /dev/null 2>&1; then
        sudo systemctl enable nginx
        sudo systemctl start nginx
        configure_nginx_content "$web_root" "$rc_local_path"
        sudo systemctl restart nginx
    else
        echo "Failed to install nginx"
        exit 3
    fi
}

# Function to configure nginx content
#
function configure_nginx_content() {
    local web_root=$1
    local rc_local_path=$2

    sudo chmod o+w $rc_local_path
    sudo tee -a  $rc_local_path > /dev/null <<EOF
cd $web_root
META_REGION_STRING=\$(curl -s 'http://metadata.google.internal/computeMetadata/v1/instance/zone' -H 'Metadata-Flavor: Google')
ZONE=\$(echo \$META_REGION_STRING | awk -F/ '{print \$4}')
sudo rm -f *.html
sudo touch index.html
sudo chmod 666 index.html
sudo echo "<h3>Ip: \$(hostname -i)</h3>" >> index.html
sudo echo "<h3>Zone: \$ZONE</h3>" >> index.html
sudo chmod 644 index.html
EOF
    sudo chmod o-w $rc_local_path
    sudo chmod +x $rc_local_path
}

# Main function to detect distribution version
#
function Main() {
    . /etc/os-release
    case $ID in
      centos)
        install_nginx "yum" "/usr/share/nginx/html"
      ;;
      *)
        echo "Unsupported OS: $ID"
        exit 1
      ;;
    esac
}

Main

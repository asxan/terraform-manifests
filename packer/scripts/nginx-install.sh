#!/bin/bash
# Script for nginx installation to check the Internal IP address of VM
# Created by Vitalii Klymov
# 08/03/2024


set -e

function debian(){
    set +e
    sudo apt list --installed -a nginx | grep nginx
    status=$(echo $?)
    set -e

    if [[ $status -eq 0 ]]; then
        sudo systemctl enable nginx
        sudo systemctl start nginx
        content-debian
    else
        sudo apt install -y nginx
        sudo apt list --installed -a nginx | grep nginx
        status=$(echo $?)
        if [[ $status -eq 0 ]]; then
            sudo systemctl enable nginx
            sudo systemctl start nginx
            content-debian
        else
            echo "Can not installed inginx"
            exit 3
        fi
    fi
}



function centos(){
    set +e
    sudo yum list installed nginx
    status=$(echo $?)
    set -e

    if [[ $status -eq 0 ]]; then
        sudo systemctl enable nginx
        sudo systemctl start nginx
        content-centos
    else
        sudo yum install -y nginx
        sudo yum list installed nginx
        status=$(echo $?)
        if [[ $status -eq 0 ]]; then
            sudo systemctl enable nginx
            sudo systemctl start nginx
            content-centos
        else
            echo "Can not installed inginx"
            exit 3
        fi
    fi
}


function content() {
    sudo echo "META_REGION_STRING=\$(curl 'http://metadata.google.internal/computeMetadata/v1/instance/zone' -H 'Metadata-Flavor: Google')" >> /etc/rc.d/rc.local
    sudo echo "ZONE=\`echo \$META_REGION_STRING | awk -F/ '{print \$4}'\`" >> /etc/rc.d/rc.local
    sudo echo '''
sudo rm -f *.html
sudo touch index.html
sudo chmod 666 index.html
sudo echo "<h3>Ip: $(hostname -i)</h3>" >> index.html
sudo echo "<h3>Zone: $ZONE</h3>" >> index.html
sudo chmod 644 index.html
''' >> /etc/rc.d/rc.local
}


function content-debian() {
    sudo chmod o+w /etc/rc.d/rc.local
    sudo echo "cd /var/www/html/" >> /etc/rc.d/rc.local
    content
    sudo chmod o-w /etc/rc.d/rc.local
    sudo chmod +x /etc/rc.d/rc.local
}


function content-centos() {
    sudo chmod o+w /etc/rc.d/rc.local
    sudo echo "cd /usr/share/nginx/html" >> /etc/rc.d/rc.local
    content
    sudo chmod o-w /etc/rc.d/rc.local
    sudo chmod +x /etc/rc.d/rc.local
}

function Main() {
    . /etc/os-release
    if [[ $ID == 'debian' ]]; then
        debian
    elif [[ $ID == 'centos' ]]; then
        centos
    else
        echo "The OS version was not detected!"
        exit 1
    fi
}

Main
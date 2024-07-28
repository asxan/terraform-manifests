#!/bin/bash
# Set up Bastion-Jump Host without the ability to login for users except asxan_agrail
# Created by Vitalii Klymov 06/02/2024

set -e
CUSTOM_PORT=33000


echo "Enable custom port $CUSTOM_PORT for sshd in SeLinux"
sudo semanage port -l | grep ssh
sudo semanage port -a -t ssh_port_t -p tcp $CUSTOM_PORT
sudo semanage port -l | grep ssh

echo "Copy custom sshd config file"
if [[ -e /tmp/sshd_config ]]; then
  sudo cp -r /tmp/sshd_config /etc/ssh/sshd_config
else
    exit
fi

echo "Restart sshd daemon server"
sudo systemctl restart sshd
sudo systemctl status sshd
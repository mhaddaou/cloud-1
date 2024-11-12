#!/bin/bash

apt-get update
apt-get install -y ansible

# home_dir=$(eval echo ~$USER)

# # Check if the SSH key already exists
# if [ -f "$home_dir/.ssh/id_rsa" ]; then
#   echo "SSH key already exists, skipping generation."
# else
#   # Generate a new SSH key
#   ssh-keygen -t rsa -b 4096 -C "mhaddaou@1337.student.ma" -f "/root/.ssh/id_rsa" -N ""
#   echo "SSH key generated successfully."
# fi

# PUBLICKEY=$(cat /root/.ssh/id_rsa.pub)

# echo $PUBLICKEY > /vagrant/pb

# # cd /home/vagrant/ansible-project

# # ansible all -m ping -i hosts

# cat /Users/mhaddaou/.vagrant.d/insecure_private_key
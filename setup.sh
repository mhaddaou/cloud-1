#!/bin/bash
set -e


# Update system
apt update

# Install required packages
apt-get install make docker-compose git -y

apt-get install docker.io -y
# Create docker group and enable Docker
groupadd docker || true
systemctl enable docker --now
# Create data directories for volumes
mkdir -p /home/asalek/data/maria_v
mkdir -p /home/asalek/data/wordpress_v

# Clone the inception project
cd /root
git clone https://github.com/Asalek/cloud_1.git
cd cloud_1

# Run docker-compose
make

echo "Setup completed successfully!"

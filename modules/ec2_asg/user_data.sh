#!/bin/bash
apt update -y && apt upgrade -y
apt install nginx -y
systemctl enable nginx
systemctl start nginx

useradd -m -s /bin/bash devopsadmin
echo "devopsadmin:StrongPassword123!" | chpasswd
usermod -aG sudo devopsadmin
echo "devopsadmin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

echo "<h1>Production Terraform EC2 + ASG</h1>" > /var/www/html/index.html

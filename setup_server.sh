#!/bin/bash

# 升级更新
sudo apt-get update
sudo apt-get upgrade -y

# 添加新用户
read -p "输入新添加用户名: " new_username
sudo adduser $new_username

# 给新用户提权
sudo usermod -aG sudo $new_username

# 禁止root登录并更改SSH端口
sudo sed -i 's/PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
read -p "请输入新的ssh端口: " new_ssh_port
sudo sed -i "s/#Port 22/Port $new_ssh_port/" /etc/ssh/sshd_config
sudo systemctl restart ssh

# 开启防火墙并开放80、443、新SSH端口
sudo ufw enable
sudo ufw allow 80
sudo ufw allow 443
sudo ufw allow $new_ssh_port

# 成功提示
echo "Setup completed successfully."

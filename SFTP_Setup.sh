#!/usr/bin/bash
apt-get update -y
apt install ssh -y
mkdir -p /data
chmod 701 /data
groupadd SFTP_USERS
sed -i '/Subsystem/s/^/#/g' /etc/ssh/sshd_config
echo "Subsystem sftp internal-sftp" >> /etc/ssh/sshd_config
echo "Match Group SFTP_USERS" >> /etc/ssh/sshd_config
echo "ChrootDirectory /data/%u" >> /etc/ssh/sshd_config
echo "ForceCommand internal-sftp" >> /etc/ssh/sshd_config
systemctl restart sshd
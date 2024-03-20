#!/bin/bash
#sudo cd /etc/yum.repos.d/
#sudo sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
#sudo sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*
#sudo dnf install -y nfs-utils
sudo yum install -y nfs-utils 
echo "================Enable firewalld================"
sudo systemctl enable firewalld --now
sudo systemctl status firewalld
echo "================Auto mount================"
sudo echo "192.168.56.210:/srv/nfs/ /mnt nfs nfsvers=3,noauto,x-systemd.automount,nofail,noatime,nolock,intr,actimeo=1800 0 0" >> /etc/fstab
sudo systemctl daemon-reload
sudo reboot
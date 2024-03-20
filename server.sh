#!/bin/bash
sudo yum install -y nfs-utils 
echo "================Enable firewall================"
systemctl enable firewalld --now
systemctl status firewalld
echo "================Allow NFS in firewall================"
sudo firewall-cmd --new-zone=nfs --permanent
sudo firewall-cmd --zone=nfs --add-service=nfs --permanent
sudo firewall-cmd --zone=nfs --permanent --add-service=rpc-bind --permanent
sudo firewall-cmd --zone=nfs --permanent --add-service=mountd --permanent
sudo firewall-cmd --zone=nfs --add-source=192.168.56.0/24 --permanent
sudo firewall-cmd --reload
sudo systemctl enable --now nfs-server
echo "================Create upload dir================"
sudo mkdir -p /srv/nfs/upload
sudo chmod 0777 /srv/nfs/upload
echo "================Configure exports================"
sudo cat << EOF > /etc/exports
/srv/nfs 192.168.56.211/32(rw,sync,root_squash)
EOF
exportfs -r
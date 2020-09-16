#!/bin/bash

#######################################################################
# 1、VPS环境(澳洲)
# 2、Centos 7
#######################################################################

#hostname set
#略

#install docker
yum install -y docker vim net-tools git
systemctl enable docker
systemctl restart docker
systemctl disable firewalld
systemctl stop firewalld

#install GUI
yum groupinstall -y "GNOME Desktop" "Graphical Administration Tools"

#get binary
cd /opt
wget http://github.com/openshift/origin/releases/download/v1.3.0/openshift-origin-server-v1.3.0-3ab7af3d097b57f933eccef684a714f2368804e7-linux-64bit.tar.gz
sleep 1
tar -zxf openshift-origin-server-v1.3.0-3ab7af3d097b57f933eccef684a714f2368804e7-linux-64bit.tar.gz
ln -s openshift-origin-server-v1.3.0-3ab7af3d097b57f933eccef684a714f2368804e7-linux-64bit /opt/openshift
echo "PATH=$PATH:/opt/openshift" >> /etc/profile
. /etc/profile
openshift version
sleep 1

#set runlevel 5
systemctl set-default graphical

shutdown -r now
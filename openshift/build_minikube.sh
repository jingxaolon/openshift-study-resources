#!/bin/bash

#first version 2020.4.14

set -x

yum install -y docker vim net-tools conntrack

systemctl enable docker
systemctl start docker

#download kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version --client
sleep 3

#install minikube
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 && chmod +x minikube
sudo mv ./minikube /usr/local/bin/

#confirm installation
minikube start --driver=none
sleep 3

minikube status

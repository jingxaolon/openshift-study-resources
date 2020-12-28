#!/bin/bash

#first version 2020.4.14

set -x

#download Istio
cd
curl -L https://istio.io/downloadIstio | sh -
echo "PATH=$PATH:/root/istio-1.5.1/bin" >> /etc/profile
. /etc/profile

#install istio
istioctl manifest apply --set profile=demo

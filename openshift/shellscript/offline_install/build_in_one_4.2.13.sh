#!/usr/bin/env bash

#set -e
set -x

rm -rf /data/ocp4
mkdir -p /data/ocp4
cd /data/ocp4

#wget -O build.dist.sh https://raw.githubusercontent.com/wangzheng422/docker_env/dev/redhat/ocp4/files/4.2/docker_images/build.dist.sh

#jq需单独安装
wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
yum install -y jq

yum -y install podman docker-distribution pigz skopeo docker buildah python3-pip 

wget http://mirror.centos.org/centos/7/os/x86_64/Packages/python-rhsm-certificates-1.19.10-1.el7_4.x86_64.rpm
rpm2cpio python-rhsm-certificates-1.19.10-1.el7_4.x86_64.rpm | cpio -iv --to-stdout ./etc/rhsm/ca/redhat-uep.pem | tee /etc/rhsm/ca/redhat-uep.pem
#不装包的情况下，提取出文件

systemctl start docker

docker login -u ****** -p ****** registry.redhat.io
docker login -u ****** -p ****** registry.access.redhat.com
docker login -u ****** -p ****** registry.connect.redhat.com

podman login -u ****** -p ****** registry.redhat.io
podman login -u ****** -p ****** registry.access.redhat.com
podman login -u ****** -p ****** registry.connect.redhat.com

# to download the pull-secret.json, open following link
# https://cloud.redhat.com/openshift/install/metal/user-provisioned
cat << EOF > /data/pull-secret.json
{"auths":{"cloud.openshift.com":{"auth":"b3BlbnNoaWZ0LXJlbGVhc2UtZGV2K2ppbmd4aWFvbG9uZzF3MGRxa2drM21rZDNjYmd4amN6dWltdDZ4ajo0TlkwRU0yUk9CQ0U0N0k4VjYxRE5LRDBJSVBaM0RVRlhGSTFKNUpCOTlNUFBNREJZTEREQ0lXMzlRM0tVMElT","email":"1198285059@qq.com"},"quay.io":{"auth":"b3BlbnNoaWZ0LXJlbGVhc2UtZGV2K2ppbmd4aWFvbG9uZzF3MGRxa2drM21rZDNjYmd4amN6dWltdDZ4ajo0TlkwRU0yUk9CQ0U0N0k4VjYxRE5LRDBJSVBaM0RVRlhGSTFKNUpCOTlNUFBNREJZTEREQ0lXMzlRM0tVMElT","email":"1198285059@qq.com"},"registry.connect.redhat.com":{"auth":"NTIyNzMyMjV8dWhjLTFXMGRxS2dLM21rZDNDYkdYamN6dUltdDZ4ajpleUpoYkdjaU9pSlNVelV4TWlKOS5leUp6ZFdJaU9pSmxaR016Tm1VM1pUZ3pZMlEwTURReFlXUXhZV00wWlRZNE16WTVOVFkzT0NKOS52NC1GOVNTWjFISzY4eU9ucllZSVphQV84cV8ySTMzSllyZDFnYnF5S1hqYjFXRzFIQVF6cEl2T2s5czdseHQ4ZThhaGxZQnBhRHJnQ09TZlZhb19WUnBNRzdQU0hXTmw5a3AzdV8yRWpxR3A4UExhVUxLSkt1STJpOENESjEwRHRlVml2a3hTWUNlZmxZRXdYSXpsUWpoQVpOZUk3cTN3ZkhpS01FbS1RYUxZc2xBMXdjM1Vwai1adjN0TmtrWHRMaUVXYTlkaG5XcHZLV0V1endadS1pTFZLMkVVeXFrQUNyMGg4aWtTU0lTWVd6blJxWXhXMDdyekM0SU5aZHBsM2ptOEpkc1VpWS1hc0QxQk9oOEpDX2JEYkFZN0ZuRE9fbTUzZTJfM1N0RUpsSHZOMmJ5SjYxYldKTnhQb2dLaF9tQ2FFZXpKTzR4a3Q4a0RQcWItMzlfV2JfV2hnOUFJMUFoZTU2MzktLXk1SEJJcGh3UjV3ZHBrcEFEVVJLWEZ4SzRtTlhIVGo4MzlLeVBpbVJMNERubHVMRHdpMlRjMVpwUUgxMWliQU5DWlZDTzFXVEZwMlRNUmtSa3p1VkVXck9DUnNZT2ZtVU1KYktvdU9MSTdnYWE2Y2xtUFNrMnRnZ2hZSUdfeU9mM0REV2VaVXEyall6Y1hmMWJ5SHZqOXFMc3BOQW5KeXNvR1Y3b01fU2ZzNjl1NFdVaHRNYWtyRUJHVVpwejdId1hwOWg5VXhGM1FKcmF4R29PRUhCTGpsNEk2T3ZKYkZGRXpDOGtYNVRyT0RhWFg1VTRKbWs4Q21RNTNfVU9lWFJkRVlqMm5oSTg3Ykg0QXNERHhIbDBxaGc4NFpQZUs4ZUFMVFVIWk5OVnRqODBkQ0l4UEpfQks3SldXZkQ4cG9ZNA==","email":"1198285059@qq.com"},"registry.redhat.io":{"auth":"NTIyNzMyMjV8dWhjLTFXMGRxS2dLM21rZDNDYkdYamN6dUltdDZ4ajpleUpoYkdjaU9pSlNVelV4TWlKOS5leUp6ZFdJaU9pSmxaR016Tm1VM1pUZ3pZMlEwTURReFlXUXhZV00wWlRZNE16WTVOVFkzT0NKOS52NC1GOVNTWjFISzY4eU9ucllZSVphQV84cV8ySTMzSllyZDFnYnF5S1hqYjFXRzFIQVF6cEl2T2s5czdseHQ4ZThhaGxZQnBhRHJnQ09TZlZhb19WUnBNRzdQU0hXTmw5a3AzdV8yRWpxR3A4UExhVUxLSkt1STJpOENESjEwRHRlVml2a3hTWUNlZmxZRXdYSXpsUWpoQVpOZUk3cTN3ZkhpS01FbS1RYUxZc2xBMXdjM1Vwai1adjN0TmtrWHRMaUVXYTlkaG5XcHZLV0V1endadS1pTFZLMkVVeXFrQUNyMGg4aWtTU0lTWVd6blJxWXhXMDdyekM0SU5aZHBsM2ptOEpkc1VpWS1hc0QxQk9oOEpDX2JEYkFZN0ZuRE9fbTUzZTJfM1N0RUpsSHZOMmJ5SjYxYldKTnhQb2dLaF9tQ2FFZXpKTzR4a3Q4a0RQcWItMzlfV2JfV2hnOUFJMUFoZTU2MzktLXk1SEJJcGh3UjV3ZHBrcEFEVVJLWEZ4SzRtTlhIVGo4MzlLeVBpbVJMNERubHVMRHdpMlRjMVpwUUgxMWliQU5DWlZDTzFXVEZwMlRNUmtSa3p1VkVXck9DUnNZT2ZtVU1KYktvdU9MSTdnYWE2Y2xtUFNrMnRnZ2hZSUdfeU9mM0REV2VaVXEyall6Y1hmMWJ5SHZqOXFMc3BOQW5KeXNvR1Y3b01fU2ZzNjl1NFdVaHRNYWtyRUJHVVpwejdId1hwOWg5VXhGM1FKcmF4R29PRUhCTGpsNEk2T3ZKYkZGRXpDOGtYNVRyT0RhWFg1VTRKbWs4Q21RNTNfVU9lWFJkRVlqMm5oSTg3Ykg0QXNERHhIbDBxaGc4NFpQZUs4ZUFMVFVIWk5OVnRqODBkQ0l4UEpfQks3SldXZkQ4cG9ZNA==","email":"1198285059@qq.com"}}}
EOF

#################################build.dist.sh###########################################
build_number_list=4.2.13

cat << EOF >>  /etc/hosts
127.0.0.1 registry.redhat.jxl
EOF

mkdir -p /etc/crts/
cd /etc/crts
openssl req \
   -newkey rsa:2048 -nodes -keyout redhat.jxl.key \
   -x509 -days 3650 -out redhat.jxl.crt -subj \
   "/C=CN/ST=GD/L=SZ/O=Global Security/OU=IT Department/CN=*.redhat.jxl"
   
#不明意图#
cp /etc/crts/redhat.jxl.crt /etc/pki/ca-trust/source/anchors/
update-ca-trust extract
####

systemctl stop docker-distribution
/bin/rm -rf /data/registry
mkdir -p /data/registry
cat << EOF > /etc/docker-distribution/registry/config.yml
version: 0.1
log:
  fields:
    service: registry
storage:
    cache:
        layerinfo: inmemory
    filesystem:
        rootdirectory: /data/registry
    delete:
        enabled: true
http:
    addr: :443
    tls:
       certificate: /etc/crts/redhat.jxl.crt
       key: /etc/crts/redhat.jxl.key
EOF

systemctl restart docker-distribution

podman login registry.redhat.jxl -u a -p a

cd /data/ocp4

install_build() {
    BUILDNUMBER=$1
    echo ${BUILDNUMBER}

    mkdir -p /data/ocp4/${BUILDNUMBER}
    cd /data/ocp4/${BUILDNUMBER}

    wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${BUILDNUMBER}/release.txt
    wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${BUILDNUMBER}/openshift-client-linux-${BUILDNUMBER}.tar.gz
    wget https://mirror.openshift.com/pub/openshift-v4/clients/ocp/${BUILDNUMBER}/openshift-install-linux-${BUILDNUMBER}.tar.gz

    tar -xzf openshift-client-linux-${BUILDNUMBER}.tar.gz -C /usr/local/bin/
    tar -xzf openshift-install-linux-${BUILDNUMBER}.tar.gz -C /usr/local/bin/

    export OCP_RELEASE=${BUILDNUMBER}
    export LOCAL_REG='registry.redhat.jxl'
    export LOCAL_REPO='ocp4/openshift4'
    export UPSTREAM_REPO='openshift-release-dev'
    export LOCAL_SECRET_JSON="/data/pull-secret.json"
    export OPENSHIFT_INSTALL_RELEASE_IMAGE_OVERRIDE=${LOCAL_REG}/${LOCAL_REPO}:${OCP_RELEASE}
	#registry.redhat.jxl/ocp4/openshift4:4.2.13
    export RELEASE_NAME="ocp-release"

    oc adm release mirror -a ${LOCAL_SECRET_JSON} \
    --from=quay.io/${UPSTREAM_REPO}/${RELEASE_NAME}:${OCP_RELEASE} \
    --to-release-image=$OPENSHIFT_INSTALL_RELEASE_IMAGE_OVERRIDE \
    --to=${LOCAL_REG}/${LOCAL_REPO}
}

install_build $build_number_list

cd /data/ocp4

wget --recursive --no-directories --no-parent https://mirror.openshift.com/pub/openshift-v4/dependencies/rhcos/4.2/latest/

wget -O ocp4-upi-helpernode-master.zip https://github.com/wangzheng422/ocp4-upi-helpernode/archive/master.zip
wget -O filetranspiler-master.zip https://github.com/wangzheng422/filetranspiler/archive/master.zip

podman pull registry.fedoraproject.org/fedora:latest
podman save registry.fedoraproject.org/fedora:latest | pigz -c > fedora.tgz

podman pull docker.io/library/registry:2
podman save docker.io/library/registry:2 | pigz -c > registry.tgz

pip3 install yq
#################################build.dist.sh###########################################
###over###

#################################image.mirror.install.sh###########################################
wget -O image.mirror.fn.sh https://raw.githubusercontent.com/wangzheng422/docker_env/dev/redhat/ocp4/files/4.2/docker_images/image.mirror.fn.sh
source image.mirror.fn.sh

wget https://raw.githubusercontent.com/wangzheng422/docker_env/dev/redhat/ocp4/files/4.2/docker_images/install.image.list
/bin/cp -f /data/ocp4/install.image.list install.image.list.tmp

cat install.image.list.tmp | sort | uniq > /data/ocp4/install.image.list.tmp.uniq

while read -r line; do

    mirror_image $line

done < install.image.list.tmp.uniq

cat yaml.image.ok.list | sort | uniq > yaml.image.ok.list.uniq

podman image prune -a
#Remove all unused images
#################################image.mirror.install.sh###########################################
###over###

cd /data
tar cf - registry/ | pigz -c > registry.tgz 
tar cf - ocp4/ | pigz -c > ocp4.tgz 

# cleanup() {
	# cd /data/ocp4
	# rm -rf epel-release-latest-7.noarch.rpm
	# yum remove -y jq podman docker-distribution pigz skopeo docker buildah python3-pip
	# rm -rf python-rhsm-certificates-1.19.10-1.el7_4.x86_64.rpm
	# rm -rf /data/pull-secret.json
	# sed -i '/jxl$/d' /etc/hosts
	# rm -rf /etc/crts/
	# rm -rf /etc/pki/ca-trust/source/anchors/redhat.jxl.crt
	# rm -rf /data/registry
# }

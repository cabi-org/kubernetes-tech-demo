#!/bin/bash

echo
echo What is your name? Format is, in lowercase, first-last
read username

echo
echo Installing Kubernetes prerequisites

echo
echo Getting latest packages list
sudo apt update

echo
echo Installing latest package updates
sudo apt upgrade -y

echo
echo Installing needed items to install Kubernetes
sudo apt install -y apt-transport-https ca-certificates software-properties-common apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo deb http://apt.kubernetes.io/ kubernetes-xenial main | sudo tee -a /etc/apt/sources.list.d/kubernetes.list

echo
echo Adding library to install Helm
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list

echo
echo Fetching available updates from Kubernetes and Helm libraries
sudo apt update

echo
echo Installing Kubernetes...
sudo apt install -y kubectl

echo
echo Installing Nano text editor...
sudo apt install -y nano

echo
echo Installing Helm...
sudo apt install -y helm

echo
echo Adding CABI Helm repos
helm repo add cabi https://helm.cabi.org/
helm repo add cabidev https://development-helm.cabi.org/
helm repo update

echo
echo Creating .kube directory
mkdir .kube

echo
echo Copying file from local machine
cp /mnt/c/k8s/$username.config .kube/cabi-internal-user
cp /mnt/c/k8s/$username.config .kube/config

echo
echo Setting up internal CABI user activation script
cat <<EOF >activate-cabi-internal-user.sh
#! /bin/bash
cp -f .kube/cabi-internal-user .kube/config
EOF
chmod +x activate-cabi-internal-user.sh

echo
echo Setting up internal CABI admin activation script

cat <<EOF >activate-cabi-internal-admin.sh
#! /bin/bash
cp -f .kube/cabi-internal-admin .kube/config
EOF
chmod +x activate-cabi-internal-admin.sh

echo
echo Setting up production CABI user activation script
cat <<EOF >activate-cabi-production-user.sh
#! /bin/bash
cp -f .kube/cabi-production-user .kube/config
EOF
chmod +x activate-cabi-production-user.sh

echo
echo Setting up production CABI admin activation script
cat <<EOF >activate-cabi-production-admin.sh
#! /bin/bash
cp -f .kube/cabi-production-admin .kube/config
EOF
chmod +x activate-cabi-production-admin.sh

bash td/setup-td-scripts-and-value-files.sh $username

#echo
#echo Add test configmaps
#td/apply-configs.sh before

echo
echo Installation of all necessary packages and value files is finished
echo

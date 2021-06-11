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
echo Installing Kubernetes
sudo apt update
sudo apt install -y kubectl

echo
echo Installing Nano text editor
sudo apt install -y nano

echo
echo Installing Helm...
curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -
echo "deb https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt update
sudo apt install helm

echo
echo Creating .kube directory
mkdir .kube

echo
echo Copying file from local machine
cp /mnt/c/k8s/$username.config .kube/config

echo
echo Set showall.sh script to be executable
chmod +x td/showall.sh

echo
echo Replace your-name with $username
sed -i "s/your-name/$username/g" td/*.yaml
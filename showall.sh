#!/bin/bash

if [ "$1" != "" ]; then
envtofetch=$1
else
envtofetch=
fi

if [ "$2" != "" ]; then
filter=$2
clear
echo
echo "Services running on $envtofetch"
echo
echo "Pods, Services, Deployments, DaemonSets and ReplicaSets"
echo "*******************************************************"
kubectl get all -A -o wide | grep $filter
echo
echo "Ingress"
echo "*******"
kubectl get ingress -A -o wide | grep $filter
echo
echo "ConfigMap"
echo "*********"
kubectl get configmap -A -o wide | grep $filter
echo
echo "Secret"
echo "******"
kubectl get secret -A -o wide | grep $filter
echo
echo "Endpoint"
echo "********"
kubectl get endpoints -A -o wide | grep $filter
echo
echo "Certificate"
echo "***********"
kubectl get certificate -A -o wide | grep $filter
echo
echo "CertificateRequest"
echo "******************"
kubectl get certificaterequest -A -o wide | grep $filter
echo
echo "PVC"
echo "**********"
kubectl get pvc -A -o wide | grep $filter

else

if [ "$1" != "" ]; then

clear
echo
echo "Services running on $envtofetch"
echo
echo "Pods, Services, Deployments, DaemonSets and ReplicaSets"
echo "*******************************************************"
kubectl get all -n $envtofetch -o wide
echo
echo "Ingress"
echo "*******"
kubectl get ingress -n $envtofetch -o wide
echo
echo "ConfigMap"
echo "*********"
kubectl get configmap -n $envtofetch -o wide
echo
echo "Secret"
echo "******"
kubectl get secret -n $envtofetch -o wide
echo
echo "Endpoint"
echo "********"
kubectl get endpoints -n $envtofetch -o wide
echo
echo "Certificate"
echo "***********"
kubectl get certificate -n $envtofetch -o wide
echo
echo "CertificateRequest"
echo "******************"
kubectl get certificaterequest -n $envtofetch -o wide
echo
echo "PVC"
echo "**********"
kubectl get pvc -n $envtofetch -o wide

else

clear
echo
echo "Services running on $envtofetch"
echo
echo "Pods, Services, Deployments, DaemonSets and ReplicaSets"
echo "*******************************************************"
kubectl get all -o wide
echo
echo "Ingress"
echo "*******"
kubectl get ingress -o wide
echo
echo "ConfigMap"
echo "*********"
kubectl get configmap -o wide
echo
echo "Secret"
echo "******"
kubectl get secret -o wide
echo
echo "Endpoint"
echo "********"
kubectl get endpoints -o wide
echo
echo "Certificate"
echo "***********"
kubectl get certificate -o wide
echo
echo "CertificateRequest"
echo "******************"
kubectl get certificaterequest -o wide
echo
echo "PVC"
echo "**********"
kubectl get pvc -o wide

fi

fi
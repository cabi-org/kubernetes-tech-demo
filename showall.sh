#!/bin/bash

if [ "$1" != "" ]; then
envtofetch=-n $1
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
echo "ClusterIssuer"
echo "***********"
kubectl get clusterissuers -A -o wide | grep $filter
echo
echo "Certificate"
echo "***********"
kubectl get certificate -A -o wide | grep $filter
echo
echo "CertificateRequest"
echo "******************"
kubectl get certificaterequest -A -o wide | grep $filter
echo
echo "PV and PVC"
echo "**********"
kubectl get pv -A -o wide | grep $filter
kubectl get pvc -A -o wide | grep $filter

else

clear
echo
echo "Services running on $envtofetch"
echo
echo "Pods, Services, Deployments, DaemonSets and ReplicaSets"
echo "*******************************************************"
kubectl get all $envtofetch -o wide
echo
echo "Ingress"
echo "*******"
kubectl get ingress $envtofetch -o wide
echo
echo "ConfigMap"
echo "*********"
kubectl get configmap $envtofetch -o wide
echo
echo "Secret"
echo "******"
kubectl get secret $envtofetch -o wide
echo
echo "Endpoint"
echo "********"
kubectl get endpoints $envtofetch -o wide
echo
echo "ClusterIssuer"
echo "***********"
kubectl get clusterissuer $envtofetch -o wide
echo
echo "Certificate"
echo "***********"
kubectl get certificate $envtofetch -o wide
echo
echo "CertificateRequest"
echo "******************"
kubectl get certificaterequest $envtofetch -o wide
echo
echo "PV and PVC"
echo "**********"
kubectl get pv $envtofetch -o wide
kubectl get pvc $envtofetch -o wide

fi

#!/bin/bash

envtofetch=""
filter=""
fetchall=false

while getopts ":A:n:f:" opt; do
  case $opt in
    A) fetchall=true
    ;;
    n) envtofetch="$OPTARG"
    ;;
    f) filter="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

if [ "$envtofetch" == "" ]; then
envtofetch="sandbox-your-name"
fi

if [ fetchall == true ] && [ "$filter" != "" ]; then
clear
echo
echo "Services running in all namespaces"
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
kubectl get clusterissuer -A -o wide | grep $filter
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

if [ "$filter" != "" ]; then
clear
echo
echo "Services (filtered) running in $envtofetch"
echo
echo "Pods, Services, Deployments, DaemonSets and ReplicaSets"
echo "*******************************************************"
kubectl get all -n $envtofetch -o wide | grep $filter
echo
echo "Ingress"
echo "*******"
kubectl get ingress -n $envtofetch -o wide | grep $filter
echo
echo "ConfigMap"
echo "*********"
kubectl get configmap -n $envtofetch -o wide | grep $filter
echo
echo "Secret"
echo "******"
kubectl get secret -n $envtofetch -o wide | grep $filter
echo
echo "Endpoint"
echo "********"
kubectl get endpoints -n $envtofetch -o wide | grep $filter
echo
echo "Certificate"
echo "***********"
kubectl get certificate -n $envtofetch -o wide | grep $filter
echo
echo "CertificateRequest"
echo "******************"
kubectl get certificaterequest -n $envtofetch -o wide | grep $filter
echo
echo "PVC"
echo "***"
kubectl get pvc -n $envtofetch -o wide | grep $filter

else 

clear
echo
echo "Services running in $envtofetch"
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
echo "***"
kubectl get pvc -n $envtofetch -o wide

fi

fi
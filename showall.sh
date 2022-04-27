#!/bin/bash

envtofetch=""
filter=""
microservice=""
fetchall="false"
types="common"

while getopts ":A:n:m:f:t:" opt; do
  case $opt in
    A) fetchall="true"
    ;;
    n) envtofetch="$OPTARG"
    ;;
    m) microservice="$OPTARG"
    ;;
    f) filter="$OPTARG"
    ;;
    t) types="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

if [ "$envtofetch" == "" ]; then
envtofetch="sandbox-your-name"
fi

if [ "$fetchall" = "true" ]; then

if [ "$filter" != "" ]; then

clear
echo
echo "Filtered items running in all namespaces"
echo
echo "Pods"
echo "****"
kubectl get pods -A -o wide | grep $filter
echo
echo "Services"
echo "********"
kubectl get svc -A -o wide | grep $filter
echo
echo "Deployments"
echo "***********"
kubectl get deploy -A -o wide | grep $filter
echo
echo "Daemon Sets"
echo "***********"
kubectl get daemonsets -A -o wide | grep $filter
if [ "$types" == "all" ]; then
echo
echo "Horizontal Pod Autoscalers"
echo "**************************"
kubectl get hpa -A -o wide | grep $filter
echo
echo "ReplicaSets"
echo "***********"
kubectl get replicasets -A -o wide | grep $filter
echo
echo "StatefulSets"
echo "************"
kubectl get statefulsets -A -o wide | grep $filter
fi
echo
echo "Cron Jobs"
echo "*********"
kubectl get cronjobs -A -o wide | grep $filter
echo
echo "Jobs"
echo "*********"
kubectl get jobs -A -o wide | grep $filter
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
if [ "$types" == "all" ]; then
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
fi
echo
if [ "$types" == "all" ]; then
echo "PV and PVC"
echo "**********"
elif
echo "PVC"
echo "***"
fi
if [ "$types" == "all" ]; then
kubectl get pv -A -o wide | grep $filter
fi
kubectl get pvc -A -o wide | grep $filter
if [ "$types" == "all" ]; then
echo
echo "MongoDB (Community)"
echo "*******************"
kubectl get mongodbcommunity -A -o wide | grep $filter
echo
echo "Atlas Projects, Clusters and Database Users"
echo "*******************************************"
kubectl get atlasprojects,atlasclusters,atlasdatabaseusers -A -o wide | grep $filter
echo
echo "RabbitMQ Clusters, Exchanges and Users"
echo "**************************************"
kubectl get rabbitmqcluster,policy,exchange,binding.rabbitmq.com,queue,user,permission -A -o wide | grep $filter
fi

elif [ "$microservice" != "" ]; then

clear
echo
echo "Items for a specific microservice running in all namespaces"
echo
echo "Pods"
echo "****"
kubectl get pods -A -o wide -l microservice=$microservice
echo
echo "Services"
echo "********"
kubectl get svc -A -o wide -l microservice=$microservice
echo
echo "Deployments"
echo "***********"
kubectl get deploy -A -o wide -l microservice=$microservice
echo
echo "Daemon Sets"
echo "***********"
kubectl get daemonsets -A -o wide -l microservice=$microservice
if [ "$types" == "all" ]; then
echo
echo "Horizontal Pod Autoscalers"
echo "**************************"
kubectl get hpa -A -o wide -l microservice=$microservice
echo
echo "ReplicaSets"
echo "***********"
kubectl get replicasets -A -o wide -l microservice=$microservice
echo
echo "StatefulSets"
echo "************"
kubectl get statefulsets -A -o wide -l microservice=$microservice
fi
echo
echo "Cron Jobs"
echo "*********"
kubectl get cronjobs -A -o wide -l microservice=$microservice
echo
echo "Jobs"
echo "*********"
kubectl get jobs -A -o wide -l microservice=$microservice
echo
echo "Ingress"
echo "*******"
kubectl get ingress -A -o wide -l microservice=$microservice
echo
echo "ConfigMap"
echo "*********"
kubectl get configmap -A -o wide -l microservice=$microservice
echo
echo "Secret"
echo "******"
kubectl get secret -A -o wide -l microservice=$microservice
if [ "$types" == "all" ]; then
echo
echo "Endpoint"
echo "********"
kubectl get endpoints -A -o wide -l microservice=$microservice
echo
echo "ClusterIssuer"
echo "***********"
kubectl get clusterissuer -A -o wide -l microservice=$microservice
echo
echo "Certificate"
echo "***********"
kubectl get certificate -A -o wide -l microservice=$microservice
echo
echo "CertificateRequest"
echo "******************"
kubectl get certificaterequest -A -o wide -l microservice=$microservice
fi
echo
if [ "$types" == "all" ]; then
echo "PV and PVC"
echo "**********"
elif
echo "PVC"
echo "***"
fi
if [ "$types" == "all" ]; then
kubectl get pv -A -o wide -l microservice=$microservice
fi
kubectl get pvc -A -o wide -l microservice=$microservice
if [ "$types" == "all" ]; then
echo
echo "MongoDB (Community)"
echo "*******************"
kubectl get mongodbcommunity -A -o wide -l microservice=$microservice
echo
echo "Atlas Projects, Clusters and Database Users"
echo "*******************************************"
kubectl get atlasprojects,atlasclusters,atlasdatabaseusers -A -o wide -l microservice=$microservice
echo
echo "RabbitMQ Clusters, Exchanges and Users"
echo "**************************************"
kubectl get rabbitmqcluster,policy,exchange,binding.rabbitmq.com,queue,user,permission -A -o wide -l microservice=$microservice
fi

else

echo
echo "You can't return all items for all namespaces"
echo

fi

elif [ "$filter" != "" ]; then

clear
echo
echo "Filtered items running in $envtofetch"
echo
echo "Pods"
echo "****"
kubectl get pods -n $envtofetch -o wide | grep $filter
echo
echo "Services"
echo "********"
kubectl get svc -n $envtofetch -o wide | grep $filter
echo
echo "Deployments"
echo "***********"
kubectl get deploy -n $envtofetch -o wide | grep $filter
echo
echo "Daemon Sets"
echo "***********"
kubectl get daemonsets -n $envtofetch -o wide | grep $filter
if [ "$types" == "all" ]; then
echo
echo "Horizontal Pod Autoscalers"
echo "**************************"
kubectl get hpa -n $envtofetch -o wide | grep $filter
echo
echo "ReplicaSets"
echo "***********"
kubectl get replicasets -n $envtofetch -o wide | grep $filter
echo
echo "StatefulSets"
echo "************"
kubectl get statefulsets -n $envtofetch -o wide | grep $filter
fi
echo
echo "Cron Jobs"
echo "*********"
kubectl get cronjobs -n $envtofetch -o wide | grep $filter
echo
echo "Jobs"
echo "*********"
kubectl get jobs -n $envtofetch -o wide | grep $filter
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
if [ "$types" == "all" ]; then
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
fi
echo
echo "PVC"
echo "***"
kubectl get pvc -n $envtofetch -o wide | grep $filter
if [ "$types" == "all" ]; then
echo
echo "MongoDB (Community)"
echo "*******************"
kubectl get mongodbcommunity -n $envtofetch -o wide | grep $filter
echo
echo "Atlas Projects, Clusters and Database Users"
echo "*******************************************"
kubectl get atlasprojects,atlasclusters,atlasdatabaseusers -n $envtofetch -o wide | grep $filter
echo
echo "RabbitMQ Clusters, Exchanges and Users"
echo "**************************************"
kubectl get rabbitmqcluster,policy,exchange,binding.rabbitmq.com,queue,user,permission -n $envtofetch -o wide | grep $filter
fi

elif [ "$microservice" != "" ]; then

clear
echo
echo "Items for a specific microservice running in $envtofetch"
echo
echo "Pods"
echo "****"
kubectl get pods -n $envtofetch -o wide -l microservice=$microservice
echo
echo "Services"
echo "********"
kubectl get svc -n $envtofetch -o wide -l microservice=$microservice
echo
echo "Deployments"
echo "***********"
kubectl get deploy -n $envtofetch -o wide -l microservice=$microservice
echo
echo "Daemon Sets"
echo "***********"
kubectl get daemonsets -n $envtofetch -o wide -l microservice=$microservice
if [ "$types" == "all" ]; then
echo
echo "Horizontal Pod Autoscalers"
echo "**************************"
kubectl get hpa -n $envtofetch -o wide -l microservice=$microservice
echo
echo "ReplicaSets"
echo "***********"
kubectl get replicasets -n $envtofetch -o wide -l microservice=$microservice
echo
echo "StatefulSets"
echo "************"
kubectl get statefulsets -n $envtofetch -o wide -l microservice=$microservice
fi
echo
echo "Cron Jobs"
echo "*********"
kubectl get cronjobs -n $envtofetch -o wide -l microservice=$microservice
echo
echo "Jobs"
echo "*********"
kubectl get jobs -n $envtofetch -o wide -l microservice=$microservice
echo
echo "Ingress"
echo "*******"
kubectl get ingress -n $envtofetch -o wide -l microservice=$microservice
echo
echo "ConfigMap"
echo "*********"
kubectl get configmap -n $envtofetch -o wide -l microservice=$microservice
echo
echo "Secret"
echo "******"
kubectl get secret -n $envtofetch -o wide -l microservice=$microservice
if [ "$types" == "all" ]; then
echo
echo "Endpoint"
echo "********"
kubectl get endpoints -n $envtofetch -o wide -l microservice=$microservice
echo
echo "ClusterIssuer"
echo "***********"
kubectl get clusterissuer -n $envtofetch -o wide -l microservice=$microservice
echo
echo "Certificate"
echo "***********"
kubectl get certificate -n $envtofetch -o wide -l microservice=$microservice
echo
echo "CertificateRequest"
echo "******************"
kubectl get certificaterequest -n $envtofetch -o wide -l microservice=$microservice
fi
echo
if [ "$types" == "all" ]; then
echo "PV and PVC"
echo "**********"
elif
echo "PVC"
echo "***"
fi
if [ "$types" == "all" ]; then
kubectl get pv -n $envtofetch -o wide -l microservice=$microservice
fi
kubectl get pvc -n $envtofetch -o wide -l microservice=$microservice
if [ "$types" == "all" ]; then
echo
echo "MongoDB (Community)"
echo "*******************"
kubectl get mongodbcommunity -n $envtofetch -o wide -l microservice=$microservice
echo
echo "Atlas Projects, Clusters and Database Users"
echo "*******************************************"
kubectl get atlasprojects,atlasclusters,atlasdatabaseusers -n $envtofetch -o wide -l microservice=$microservice
echo
echo "RabbitMQ Clusters, Exchanges and Users"
echo "**************************************"
kubectl get rabbitmqcluster,policy,exchange,binding.rabbitmq.com,queue,user,permission -n $envtofetch -o wide -l microservice=$microservice
fi

else 

clear
echo
echo "All items running in $envtofetch"
echo
echo "Pods"
echo "****"
kubectl get pods -n $envtofetch -o wide
echo
echo "Services"
echo "********"
kubectl get svc -n $envtofetch -o wide
echo
echo "Deployments"
echo "***********"
kubectl get deploy -n $envtofetch -o wide
echo
echo "Daemon Sets"
echo "***********"
kubectl get daemonsets -n $envtofetch -o wide
if [ "$types" == "all" ]; then
echo
echo "Horizontal Pod Autoscalers"
echo "**************************"
kubectl get hpa -n $envtofetch -o wide
echo
echo "ReplicaSets"
echo "***********"
kubectl get replicasets -n $envtofetch -o wide
echo
echo "StatefulSets"
echo "************"
kubectl get statefulsets -n $envtofetch -o wide
fi
echo
echo "Cron Jobs"
echo "*********"
kubectl get cronjobs -n $envtofetch -o wide
echo
echo "Jobs"
echo "*********"
kubectl get jobs -n $envtofetch -o wide
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
if [ "$types" == "all" ]; then
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
fi
echo
echo "PVC"
echo "***"
kubectl get pvc -n $envtofetch -o wide
if [ "$types" == "all" ]; then
echo
echo "MongoDB (Community)"
echo "*******************"
kubectl get mongodbcommunity -n $envtofetch -o wide
echo
echo "Atlas Projects, Clusters and Database Users"
echo "*******************************************"
kubectl get atlasprojects,atlasclusters,atlasdatabaseusers -n $envtofetch -o wide
echo
echo "RabbitMQ Clusters, Exchanges and Users"
echo "**************************************"
kubectl get rabbitmqcluster,policy,exchange,binding.rabbitmq.com,queue,user,permission -n $envtofetch -o wide 
fi

fi
#!/bin/bash

MICROSERVICE=$1-wordpress

if [ "$2" == "" ]; then
  NAMESPACE=development
else
  NAMESPACE=$2
fi

CREDENTIALS=$(kubectl get -n $NAMESPACE secrets/$MICROSERVICE-wp-sftp-users --template={{.data.users}} | base64 -d)
IP=$(kubectl get svc/$MICROSERVICE-wp-sftp -n $NAMESPACE --template='{{(index .status.loadBalancer.ingress 0).ip}}')

IFS=':' read -r -a CREDENTIALS <<< "$CREDENTIALS"

echo "Username: ${CREDENTIALS[0]}"
echo "Password: ${CREDENTIALS[1]}"
echo "IP: $IP"

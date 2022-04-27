#!/bin/bash

if [ "$2" != "" ]; then
POD_NAME=$(kubectl get -n $2 pods -l run=$1 --template='{{(index .items 0).metadata.name}}')
kubectl exec -it $POD_NAME -n $2 -- bash
else
POD_NAME=$(kubectl get pods -l run=$1 --template='{{(index .items 0).metadata.name}}')
kubectl exec -it $POD_NAME -- bash
fi

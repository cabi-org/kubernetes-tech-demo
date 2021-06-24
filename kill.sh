#!/bin/bash

if [ "$2" != "" ]; then
kubectl delete pod $1 -n $2 --grace-period=0 --force
else
kubectl delete pod $1 --grace-period=0 --force
fi

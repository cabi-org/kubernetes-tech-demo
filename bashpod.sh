#!/bin/bash

if [ "$2" != "" ]; then
kubectl exec -it $1 -n $2 -- bash
else
kubectl exec -it $1 -- bash
fi

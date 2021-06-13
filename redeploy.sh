#!/bin/bash

if [ "$2" != "" ]; then
kubectl rollout restart deploy $1 -n $1
else
kubectl rollout restart deploy $1
fi

#!/bin/bash

NAMESPACE=""

while getopts ":n:" opt; do
  case $opt in
    n) NAMESPACE="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

if [ "$NAMESPACE" == "" ]; then
kubectl get pods -A -o wide | grep -v Running
else
kubectl get pods -n $NAMESPACE -o wide | grep -v Running
fi
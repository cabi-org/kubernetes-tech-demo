#!/bin/bash

kubectl apply -f td/configmap-withrefresh-$1
kubectl apply -f td/configmap-withoutrefresh-$1

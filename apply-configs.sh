#!/bin/bash

kubectl apply -f td/configmap-withrefresh-$1.yaml
kubectl apply -f td/configmap-withoutrefresh-$1.yaml

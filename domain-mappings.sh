#!/bin/bash

DOMAIN=$1
NAMESPACE=$2

if [ "$NAMESPACE" == "" ]; then
$DOMAIN=production
if [ "$DOMAIN" == development* ]; then
NAMESPACE=development
elif [ "$DOMAIN" == staging* ]; then
NAMESPACE=staging
elif [ "$DOMAIN" == *.cabisandbox.org ]; then
NAMESPACE=sandbox-${DOMAIN/.cabisandbox.org/""}
fi
fi

kubectl get ingress -n $NAMESPACE -o json | jq -r '.items[].spec.rules[] | select (.host == "$DOMAIN") | .http.paths[].path'

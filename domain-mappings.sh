#!/bin/bash

DOMAIN=$1
NAMESPACE=$2

if [ "$NAMESPACE" == "" ]; then
NAMESPACE=production
if [[ "$DOMAIN" == development* ]]; then
NAMESPACE=development
elif [[ "$DOMAIN" == staging* ]]; then
NAMESPACE=staging
elif [[ "$DOMAIN" == *.cabisandbox.org ]]; then
NAMESPACE=sandbox-${DOMAIN/.cabisandbox.org/""}
fi
fi

echo
echo "Paths mapped for domain $DOMAIN in $NAMESPACE"
echo

kubectl get ingress -n $NAMESPACE -o json | jq -r '.items[].spec.rules[] | select (.host == "$DOMAIN") | .http.paths[].path'

#!/bin/bash

NAMESPACE=$1

if [ "$NAMESPACE" == "" ]; then
NAMESPACE=development
fi

echo
echo "Domains mapped from $NAMESPACE"
echo

DOMAINS=$(kubectl get ingress -n $NAMESPACE -o json | jq -r ".items[].spec.rules[] | select ((.http != null) and (.http.paths[].path == \"/\")) | .host")

while IFS= read -r DOMAIN; do
echo $DOMAIN
kubectl get ingress -n $NAMESPACE -o json | jq -r ".items[].spec.rules[] | select (.host == \"$DOMAIN\") | \" - \" + .http.paths[].path"
echo
done <<< "$DOMAINS"

echo
echo "Redirects mapped from $NAMESPACE"
echo

kubectl get ingress -n $NAMESPACE -o json | jq -r ".items[].spec.rules[] | select (.http == null) | .host"
#!/bin/bash

NAMESPACE=$1
if [ "$NAMESPACE" == "" ]; then
NAMESPACE=development
fi

echo
echo "Domains mapped from $NAMESPACE"
echo

DOMAINS=$(kubectl get ingress -n $NAMESPACE -o json | jq -r ".items[].spec.rules[] | select ((.http != null) ) | .host")
DOMAINS=$(echo "$DOMAINS" | sort | uniq)

while IFS= read -r DOMAIN; do
echo $DOMAIN
kubectl get ingress -n $NAMESPACE -o json | jq -r ".items[].spec.rules[] | select (.host == \"$DOMAIN\") | \" - \" + .http.paths[].path + \" [\" + .http.paths[].backend.service.name + \"]\""
echo
done <<< "$DOMAINS"

echo
echo "Redirects mapped from $NAMESPACE"
echo

kubectl get ingress -n $NAMESPACE -o json | jq -r ".items[].spec.rules[] | select (.http == null) | .host"
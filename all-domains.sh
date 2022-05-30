#!/bin/bash

NAMESPACE=$1
MARKDOWN=$false
if [ "$NAMESPACE" == "" ]; then
NAMESPACE=development
fi
if [ "$2" == "md" ]; then
MARKDOWN=$true
fi

echo
echo "Domains mapped from $NAMESPACE"
echo

DOMAINS=$(kubectl get ingress -n $NAMESPACE -o json | jq -r ".items[].spec.rules[] | select ((.http != null) ) | .host")
DOMAINS=$(echo "$DOMAINS" | sort | uniq)

if [ $MARKDOWN -eq $true ]; then
echo "|Path|Application|"
echo "|---|---|"
while IFS= read -r DOMAIN; do
echo "|$DOMAIN|"
kubectl get ingress -n $NAMESPACE -o json | jq -r ".items[].spec.rules[] | select (.host == \"$DOMAIN\") | \"|\" + .http.paths[].path + \"|\" + .http.paths[].backend.service.name + \"|\""
done <<< "$DOMAINS"
else
while IFS= read -r DOMAIN; do
echo "$DOMAIN"
kubectl get ingress -n $NAMESPACE -o json | jq -r ".items[].spec.rules[] | select (.host == \"$DOMAIN\") | \" - \" + .http.paths[].path + \" [\" + .http.paths[].backend.service.name + \"]\""
echo
done <<< "$DOMAINS"
fi

echo
echo "Redirects mapped from $NAMESPACE"
echo

kubectl get ingress -n $NAMESPACE -o json | jq -r ".items[].spec.rules[] | select (.http == null) | .host"
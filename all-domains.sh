#!/bin/bash

NAMESPACE=$1
MARKDOWN=0
if [ "$NAMESPACE" == "" ]; then
NAMESPACE=development
fi
if [ "$2" == "md" ]; then
MARKDOWN=1
fi

echo
echo "Domains mapped from $NAMESPACE"
echo

DOMAINS=$(kubectl get ingress -n $NAMESPACE -o json | jq -r ".items[].spec.rules[] | select ((.http != null) ) | .host")
DOMAINS=$(echo "$DOMAINS" | sort | uniq)

if [ $MARKDOWN -eq 1 ]; then
echo "|Path|Application|Purpose|"
echo "|---|---|---|"
while IFS= read -r DOMAIN; do
echo "|**[$DOMAIN](https://$DOMAIN/)**|"
kubectl get ingress -n $NAMESPACE -o json | jq -r ".items[] | .metadata.annotations.description as \$description | .spec.rules[] | select (.host == \"$DOMAIN\") | \"|\" + (.http.paths[].path | (gsub(\"[|]\";\"\\\|\"))) + \"|\" + .http.paths[].backend.service.name + \"|\" + \$description"
done <<< "$DOMAINS"
else
while IFS= read -r DOMAIN; do
echo "$DOMAIN"
kubectl get ingress -n $NAMESPACE -o json | jq -r ".items[] | .metadata.annotations.description as \$description | .spec.rules[] | select (.host == \"$DOMAIN\") | \" - \" + .http.paths[].path + \" [\" + .http.paths[].backend.service.name + \" - \" + (\$description // \"<no description available>\") + \"]\""
echo
done <<< "$DOMAINS"
fi

echo
echo "Redirects mapped from $NAMESPACE"
echo

kubectl get ingress -n $NAMESPACE -o json | jq -r ".items[].spec.rules[] | select (.http == null) | .host"
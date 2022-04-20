#!/bin/bash

NAMESPACE="development"
MICROSERVICE=""
DATABASETYPE="mssql"

while getopts ":n:m:t:" opt; do
  case $opt in
    n) NAMESPACE="$OPTARG"
    ;;
    m) MICROSERVICE="$OPTARG"
    ;;
    t) DATABASETYPE="$OPTARG"
    ;;
    \?) echo "Invalid option -$OPTARG" >&2
    ;;
  esac
done

USERNAME=$(kubectl get -n $NAMESPACE secrets/$MICROSERVICE-$DATABASETYPE --template={{.data.Username}} | base64 -d)
PASSWORD=$(kubectl get -n $NAMESPACE secrets/$MICROSERVICE-$DATABASETYPE --template={{.data.Password}} | base64 -d)

echo
echo "Database ($DATABASETYPE) credentials for $MICROSERVICE on $NAMESPACE"
echo
echo "Username: $USERNAME"
echo "Password: $PASSWORD"
echo

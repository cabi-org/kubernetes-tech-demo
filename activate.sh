#! /bin/bash
ENVIR=$1
USER_OR_ADMIN=$2
COMPANY=$3

if [ "$ENVIR" == "" ]; then
ENVIR=internal
fi

if [ "$USER_OR_ADMIN" == "" ]; then
USER_OR_ADMIN=user
fi

if [ "$COMPANY" == "" ]; then
COMPANY=cabi
fi

echo "Attempting to activate $USER_OR_ADMIN on $ENVIR cluster"
cp -f ".kube/$COMPANY-$ENVIR-$USER_OR_ADMIN" .kube/config
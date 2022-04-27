#!/bin/bash

USER_NAME=$1

if [ "$USER_NAME" == "" ]; then
USER_NAME=your-name
fi

rm -R -f td && git clone https://github.com/cabi-org/kubernetes-tech-demo.git td && bash td/setup-td-scripts-and-value-files.sh "$USER_NAME"
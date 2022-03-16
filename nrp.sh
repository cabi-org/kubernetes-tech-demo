#!/bin/bash

kubectl get pods -A -o wide | grep -v Running

#!/bin/bash

kubectl describe node | grep "Non-terminated Pods"

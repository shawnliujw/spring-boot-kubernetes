#!/usr/bin/env bash

kubectl apply -f mongodb-configmap.yaml
kubectl apply -f mongodb-secret.yaml
kubectl apply -f mongodb-deployment.yaml
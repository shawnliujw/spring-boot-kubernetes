#!/usr/bin/env bash

kubectl apply -f kubernetes/mongodb-configmap.yaml
kubectl apply -f kubernetes/mongodb-secret.yaml
kubectl apply -f kubernetes/mongodb-deployment.yaml
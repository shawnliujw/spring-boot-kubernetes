#!/usr/bin/env bash

kubectl apply -f kubernetes/employee-deployment.yaml
kubectl apply -f kubernetes/department-deployment.yaml
kubectl apply -f kubernetes/organization-deployment.yaml
kubectl apply -f kubernetes/ingress.yaml
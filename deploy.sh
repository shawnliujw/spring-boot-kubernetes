#!/usr/bin/env bash

kubectl apply -f kubernetes/projects/employee-deployment.yaml
kubectl apply -f kubernetes/projects/department-deployment.yaml
kubectl apply -f kubernetes/projects/organization-deployment.yaml
kubectl apply -f kubernetes/ingress.yaml
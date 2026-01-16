#!/bin/bash

echo "Verifying clusters"
aws eks list-clusters --region us-east-1
aws eks list-clusters --region eu-west-1
aws eks list-clusters --region ap-south-1

echo "Checking Kubernetes resources"
kubectl get nodes
kubectl get pods
kubectl get svc

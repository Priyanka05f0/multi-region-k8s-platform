#!/bin/bash
set -e

echo "Deploying EKS clusters in all regions"

cd terraform/environments/us-east-1 && terraform apply -auto-approve
cd ../eu-west-1 && terraform apply -auto-approve
cd ../ap-south-1 && terraform apply -auto-approve

#!/bin/bash
set -e

echo "Destroying infrastructure"

cd terraform/environments/us-east-1 && terraform destroy -auto-approve
cd ../eu-west-1 && terraform destroy -auto-approve
cd ../ap-south-1 && terraform destroy -auto-approve

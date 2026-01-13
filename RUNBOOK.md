# Runbook – Multi-Region Kubernetes Platform

## Purpose
This document provides step-by-step instructions to deploy, verify, and manage the multi-region EKS platform.

---

## Prerequisites
Ensure the following tools are installed:
- AWS CLI
- Terraform
- kubectl

Also ensure:
```bash
aws configure
```
is completed with valid credentials.

## Deployment Steps

### Deploy in us-east-1
```bash
cd terraform/environments/us-east-1
terraform init
terraform apply -auto-approve
```
### Deploy in eu-west-1
```bash
cd ../eu-west-1
terraform init
terraform apply -auto-approve
```
### Deploy in ap-south-1
```bash
cd ../ap-south-1
terraform init
terraform apply -auto-approve
```
### Verification Steps

Check if clusters exist:
```bash
aws eks list-clusters --region us-east-1
aws eks list-clusters --region eu-west-1
aws eks list-clusters --region ap-south-1
```
Configure kubectl for a cluster:
```bash
aws eks update-kubeconfig --region us-east-1 --name multi-region-k8s-us-east-1
kubectl get nodes
```
Repeat for other regions as needed.

## Common Issues & Fixes

1. Terraform Init Errors

Fix: Delete state cache and reinitialize.
```bash
rm -rf .terraform .terraform.lock.hcl
terraform init
```

2. No Nodes Showing

Reason: Only control plane is created (no worker nodes configured).
This is expected for this project.

3. AWS Permission Errors

Fix: Verify IAM permissions and run:
```bash
aws sts get-caller-identity
```

Cleanup (Optional)
To destroy infrastructure:
```bash
terraform destroy -auto-approve
```

Run this inside each region directory.

## Summary

This runbook ensures consistent deployment, verification, and troubleshooting of the multi-region EKS infrastructure using Terraform.
---
# Multi-Region Kubernetes Platform

## Overview
This project demonstrates how to deploy Kubernetes clusters in multiple AWS regions using Terraform and Amazon EKS.  
Each region has its own Virtual Private Cloud (VPC), subnets, and an independent EKS cluster.

The goal of this project is to show how a highly available, multi-region Kubernetes infrastructure can be created using Infrastructure as Code (IaC).

---

## Regions Deployed
The following AWS regions are used:
- us-east-1
- eu-west-1
- ap-south-1

Each region contains:
- A dedicated VPC
- Two public subnets
- An Amazon EKS cluster

---

## Project Structure
```
multi-region-k8s-platform/
├── terraform/
│ ├── modules/
│ │ ├── vpc/
│ │ └── eks/
│ └── environments/
│ ├── us-east-1/
│ ├── eu-west-1/
│ └── ap-south-1/
├── ARCHITECTURE.md
├── RUNBOOK.md
├── submission.yml
└── README.md
```

---

## How to Deploy

Make sure AWS CLI, Terraform, and kubectl are installed.

```bash
cd terraform/environments/us-east-1
terraform init
terraform apply -auto-approve
```
```bash
cd ../eu-west-1
terraform init
terraform apply -auto-approve
```
```bash
cd ../ap-south-1
terraform init
terraform apply -auto-approve
```
## Application Deployment (Kubernetes)

The sample application validates that the EKS cluster, node group, and load balancer are working correctly.

A sample application was deployed to the ap-south-1 cluster using Kubernetes manifests.

```bash
kubectl apply -f gitops/apps/sample-app/deployment.yaml
kubectl apply -f gitops/apps/sample-app/service.yaml
kubectl get pods
kubectl get svc
curl http://<EXTERNAL-IP>
```
---

## Database & Caching (Step 4)

The platform includes basic data services deployed inside Kubernetes:

- PostgreSQL is used as the relational database
- Redis is used as an in-memory cache

These services are deployed using Kubernetes manifests located under:

gitops/apps/postgres/  
gitops/apps/redis/

Both services are exposed internally using ClusterIP services.

---

## Observability (Step 5)

Basic observability is implemented using Prometheus.
Prometheus can be accessed via kubectl port-forward if required.

- Prometheus runs inside a dedicated namespace
- It enables monitoring of Kubernetes workloads

Manifests are located under:

gitops/apps/observability/

---

## How to Verify

```bash
aws eks list-clusters --region us-east-1
aws eks list-clusters --region eu-west-1
aws eks list-clusters --region ap-south-1
```

## Outcome

After deployment, three independent EKS clusters are created across different regions.
This demonstrates:

- Infrastructure automation using Terraform
- Multi-region cloud design
- Scalable Kubernetes architecture

## Conclusion

This project successfully implements a multi-region Kubernetes platform using AWS EKS and Terraform, providing a foundation for highly available cloud-native applications.

---



---

# 📄 2️⃣ ARCHITECTURE.md (Design Explanation)

# Architecture – Multi-Region Kubernetes Platform

## High-Level Design
The platform is designed to deploy Amazon EKS clusters in multiple AWS regions using Terraform.  
Each region is fully isolated and contains its own networking and compute resources.

---

## Architecture Components

### 1. VPC per Region
For each AWS region:
- A dedicated Virtual Private Cloud (VPC) is created.
- This ensures network isolation between regions.

### 2. Subnets
Inside each VPC:
- Two public subnets are created in different Availability Zones.
- This enables high availability within a region.

### 3. Internet Gateway and Routing
- An Internet Gateway is attached to each VPC.
- A public route table routes internet traffic to the subnets.

### 4. Amazon EKS Cluster
- One EKS cluster is created per region.
- Each cluster uses the VPC and subnets from that region.
- Clusters are independent and do not depend on each other.

---
## Kubernetes Layer (Application)

Each EKS cluster runs Kubernetes workloads on managed worker nodes:
- A sample application is deployed using a Deployment object.
- A Service of type LoadBalancer exposes the application externally.
- AWS automatically provisions an Elastic Load Balancer per service.
Traffic Flow:
```
User → AWS Load Balancer → EKS Worker Node → Pod (Application)
```
This validates that the cluster is fully functional and capable of serving production workloads.

## Multi-Region Strategy
- Regions operate independently.
- Failure in one region does not impact the others.
- Enables geographic redundancy and disaster recovery.

---

## Database & Caching Layer (Step 4)

To support application data storage and caching, the platform includes in-cluster
database and cache services deployed using Kubernetes manifests.

### PostgreSQL
- Deployed as a Kubernetes Deployment inside the cluster
- Exposed internally using a ClusterIP service
- Used for persistent application data storage

### Redis
- Deployed as a lightweight in-memory cache
- Exposed internally using a ClusterIP service
- Used to improve application performance and reduce database load

These components are deployed using GitOps-style manifests located in:
```
gitops/apps/postgres/  
gitops/apps/redis/
```

This design keeps infrastructure (Terraform) separate from application services
(Kubernetes manifests), following best practices for cloud-native platforms.

## Supporting Services

### Database & Caching
- PostgreSQL provides persistent relational storage
- Redis provides fast in-memory caching
- Both run inside Kubernetes as internal services

### Observability
- Prometheus is deployed for monitoring
- Runs in a dedicated namespace
- Enables visibility into cluster workloads

Manifests are maintained under:

gitops/apps/observability/


## Logical Architecture Diagram

User → AWS Region (VPC → Subnets → EKS Cluster)

This structure is repeated for:
- us-east-1
- eu-west-1
- ap-south-1

---

## Benefits
- High Availability
- Fault Isolation
- Scalability
- Infrastructure as Code using Terraform

---

## Summary
The architecture follows a modular and region-isolated design, making it suitable for production-ready, multi-region Kubernetes deployments.
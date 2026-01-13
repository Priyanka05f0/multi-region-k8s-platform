provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source        = "../../modules/vpc"
  region        = "ap-south-1"
  project_name  = "multi-region-k8s"
}

module "eks" {
  source        = "../../modules/eks"
  region        = "ap-south-1"
  project_name  = "multi-region-k8s"
  vpc_id        = module.vpc.vpc_id
  subnet_ids    = module.vpc.subnet_ids
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "cluster_name" {
  value = module.eks.cluster_name
}

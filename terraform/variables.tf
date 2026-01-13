variable "region" {
  description = "AWS region to deploy resources"
  type        = string
}

variable "project_name" {
  description = "Project name for tagging"
  type        = string
  default     = "multi-region-k8s"
}

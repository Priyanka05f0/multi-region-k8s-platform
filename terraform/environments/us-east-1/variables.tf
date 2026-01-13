variable "region" {
  type    = string
  default = "us-east-1"
}

variable "project_name" {
  type    = string
  default = "multi-region-k8s"
}

variable "cidr_block" {
  type    = string
  default = "10.0.0.0/16"
}

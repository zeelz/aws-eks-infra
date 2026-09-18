variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "vpc_id" {
  description = "Existing VPC ID"
  type        = string
}

variable "subnet_ids" {
  description = "All existing VPC subnets used by the EKS cluster"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Existing private subnets for EKS worker nodes"
  type        = list(string)
}

variable "cluster_role_arn" {
  description = "Existing EKS cluster IAM role ARN"
  type        = string
}

variable "node_group_role_arn" {
  description = "Existing EKS node group IAM role ARN"
  type        = string
}
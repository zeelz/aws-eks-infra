terraform {
  required_version = ">= 1.5.7"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  # transfer state file to s3
  backend "s3" {
      bucket  = "zeelz-terraform-bucket"
      key     = "eks-terraform.tfstate"
      encrypt   = true
      region    = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

# -------------------------
# Existing VPC
# -------------------------

data "aws_vpc" "existing" {
  id = var.vpc_id
}

# -------------------------
# EKS Cluster
# -------------------------

resource "aws_eks_cluster" "main" {
  name     = var.cluster_name
  role_arn = var.cluster_role_arn
  access_config {
    authentication_mode                         = "API_AND_CONFIG_MAP"
    bootstrap_cluster_creator_admin_permissions = true
  }
  vpc_config {
    subnet_ids = var.subnet_ids

    endpoint_private_access = true
    endpoint_public_access  = true
  }

  tags = {
    Name = var.cluster_name
  }
}

# -------------------------
# Managed Node Group
# -------------------------

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.cluster_name}-nodes"

  node_role_arn = var.node_group_role_arn

  # Put worker nodes in the private subnets
  subnet_ids = var.private_subnet_ids

  instance_types = ["t3.medium"]

  capacity_type = "ON_DEMAND"

  scaling_config {
    desired_size = 2
    min_size     = 2
    max_size     = 2
  }

  disk_size = 20

  update_config {
    max_unavailable = 1
  }

  tags = {
    Name = "${var.cluster_name}-nodes"
  }

  depends_on = [
    aws_eks_cluster.main
  ]
}
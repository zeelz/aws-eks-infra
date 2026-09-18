aws_region   = "us-east-1"
cluster_name = "eks-cluster-08"
vpc_id = "vpc-0daa5a5bfcb587f51"

# 2 public + 2 private
subnet_ids = [
    "subnet-0cf025377e84b4301",
    "subnet-03a259eab6df2eb75",
    "subnet-00c0e85fe8ef58785",
    "subnet-0252339aac3f8f20f"
]

# Worker nodes
private_subnet_ids = [
    "subnet-0cf025377e84b4301",
    "subnet-0252339aac3f8f20f"
]

cluster_role_arn = "arn:aws:iam::553917154144:role/eks-cluster-role"
node_group_role_arn = "arn:aws:iam::553917154144:role/node-group-role"
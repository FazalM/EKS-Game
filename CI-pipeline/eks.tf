module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 21.0"

  name               = "my-cluster"
  kubernetes_version = "1.33"

  addons = {
    coredns                = {}
    eks-pod-identity-agent = {
      before_compute = true
    }
    kube-proxy             = {}
    vpc-cni                = {
      before_compute = true
    }
  }

  # Optional
  endpoint_public_access = true

  endpoint_public_access_cidrs = ["0.0.0.0/0"] #change to personal once testing is complete

  # Optional: Adds the current caller identity as an administrator via cluster access entry
  enable_cluster_creator_admin_permissions = true

  vpc_id     = data.terraform_remote_state.bootstrap.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.bootstrap.outputs.private_subnet_ids
  control_plane_subnet_ids = data.terraform_remote_state.bootstrap.outputs.public_subnet_ids

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    example = {
      # Starting on 1.30, AL2023 is the default AMI type for EKS managed node groups
      ami_type       = "AL2023_x86_64_STANDARD"
      instance_types = ["t3.medium"]

      min_size     = 1
      max_size     = 2
      desired_size = 2
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
  }
  # I created this so the cluster allows run permission outside the master account
  access_entries = {
    github_actions = {
      principal_arn = aws_iam_role.github_actions_role.arn

      policy_associations = {
        github_actions_admin = {
          policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"
          access_scope = {
            type = "cluster"
          }
        }
      }
    }
  }
}
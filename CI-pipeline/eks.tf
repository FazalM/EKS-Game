module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "21.0.9"

  name               = "my-eks-cluster"
  kubernetes_version = "1.30"

  vpc_id     = data.terraform_remote_state.bootstrap.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.bootstrap.outputs.private_subnet_ids

  create_iam_role           = false
  iam_role_arn              = local.cluster_role_arn

  create_security_group = false
  security_group_id = local.cluster_sg_id



  eks_managed_node_groups = {
    default = {
      instance_types                = ["t2.micro"]
      desired_size                  = 1
      max_size                      = 4
      min_size                      = 1
      iam_role_arn                  = local.node_role_arn
      additional_security_group_ids = [local.node_sg_id]
    }
  }
}
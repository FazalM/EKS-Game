# Fetch kubeconfig to use kubernetes provider
data "aws_eks_cluster" "cluster" {
  name = module.eks.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.cluster.token
}

# Map IAM roles to Kubernetes RBAC
resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode([
      {
        rolearn  = local.node_role_arn
        username = "system:node:{{EC2PrivateDNSName}}"
        groups   = ["system:bootstrappers", "system:nodes"]
      },
      {
        rolearn  = local.cluster_role_arn
        username = "admin"
        groups   = ["system:masters"]
      }
    ])

    #mapUsers = yamlencode([
    #    {
    #      userarn  = "arn:aws:iam::123456789012:user/dev-user1"
    #      username = "dev-user1"
    #      groups   = ["system:masters"]
    #    },
    #    {
    #      userarn  = "arn:aws:iam::123456789012:user/qa-user2"
    #      username = "qa-user2"
    #      groups   = ["view"]
    #    }
    #  ])
  }
}

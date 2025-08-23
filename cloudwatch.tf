# -------------------------------
# CloudWatch log groups for EKS
# -------------------------------
resource "aws_cloudwatch_log_group" "eks_api" {
  name              = "/aws/eks/${module.eks.cluster_name}/api"
  retention_in_days = 30
  tags = {
    Environment = "dev"
    Project     = "my-eks-cluster"
  }
}

resource "aws_cloudwatch_log_group" "eks_audit" {
  name              = "/aws/eks/${module.eks.cluster_name}/audit"
  retention_in_days = 30
  tags = {
    Environment = "dev"
    Project     = "my-eks-cluster"
  }
}

resource "aws_cloudwatch_log_group" "eks_authenticator" {
  name              = "/aws/eks/${module.eks.cluster_name}/authenticator"
  retention_in_days = 30
  tags = {
    Environment = "dev"
    Project     = "my-eks-cluster"
  }
}

resource "aws_cloudwatch_log_group" "eks_controller_manager" {
  name              = "/aws/eks/${module.eks.cluster_name}/controllerManager"
  retention_in_days = 30
  tags = {
    Environment = "dev"
    Project     = "my-eks-cluster"
  }
}

resource "aws_cloudwatch_log_group" "eks_scheduler" {
  name              = "/aws/eks/${module.eks.cluster_name}/scheduler"
  retention_in_days = 30
  tags = {
    Environment = "dev"
    Project     = "my-eks-cluster"
  }
}

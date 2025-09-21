data "aws_iam_policy_document" "github_oidc_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Federated"
      identifiers = [data.terraform_remote_state.bootstrap.outputs.github_oidc_provider_arn]
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values   = ["repo:Fazal/my-devops-app:*"]
    }
  }
}

resource "aws_iam_role" "github_actions_role" {
  name               = "GitHubActionsRole"
  assume_role_policy = data.aws_iam_policy_document.github_oidc_assume_role.json
}

# Attach policies (example: ECR + EKS)
resource "aws_iam_role_policy_attachment" "ecr_access" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryFullAccess"
}

# For cluster-level API calls
resource "aws_iam_role_policy_attachment" "eks_cluster" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

# For interacting with EKS services
resource "aws_iam_role_policy_attachment" "eks_service" {
  role       = aws_iam_role.github_actions_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
}


resource "aws_iam_role" "ecr_irsa_role" {
  name = "eks-ecr-irsa-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = module.eks.oidc_provider_arn
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            # system:serviceaccount:<namespace>:<serviceaccount-name>
            "${module.eks.oidc_provider}:sub" = "system:serviceaccount:default:ecr-sa"
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecr_readonly" {
  role       = aws_iam_role.ecr_irsa_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

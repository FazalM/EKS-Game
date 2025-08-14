terraform {
  backend "s3" {
    bucket         = "fm-my-unique-terraform-boot-game-bucket-2025"
    key            = "eks/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}

resource "aws_ecr_repository" "my_eks_app_repo" {
  name                 = "my-eks-app-repo"
  image_tag_mutability = "MUTABLE"
  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}//
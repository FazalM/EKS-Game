terraform {
  backend "s3" {
    bucket         = "fm-my-unique-terraform-boot-game-bucket-2025"
    key            = "cd/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}

data "terraform_remote_state" "bootstrap" {
  backend = "s3"
  config = {
    bucket = "fm-my-unique-terraform-boot-game-bucket-2025"
    key    = "bootstrap/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "eks" {
  backend = "s3"
  config = {
    bucket = "fm-my-unique-terraform-boot-game-bucket-2025"
    key    = "eks/terraform.tfstate"
    region = "us-east-1"
  }
}

data "aws_eks_cluster_auth" "cluster" {
  name = data.terraform_remote_state.eks.outputs.cluster_id
}
 
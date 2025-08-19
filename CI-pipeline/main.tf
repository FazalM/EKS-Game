terraform {
  backend "s3" {
    bucket         = "fm-my-unique-terraform-boot-game-bucket-2025"
    key            = "eks/terraform.tfstate"
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

locals {
  ecr_uri          = data.terraform_remote_state.bootstrap.outputs.ecr_repository_uri
  cluster_role_arn = data.terraform_remote_state.bootstrap.outputs.cluster_role_arn
  node_role_arn    = data.terraform_remote_state.bootstrap.outputs.node_role_arn
  cluster_sg_id    = data.terraform_remote_state.bootstrap.outputs.eks_cluster_sg_id
  node_sg_id       = data.terraform_remote_state.bootstrap.outputs.eks_node_sg_id
}

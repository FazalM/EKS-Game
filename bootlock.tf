terraform {
  backend "s3" {
    bucket         = "fm-my-unique-terraform-boot-game-bucket-2025"
    key            = "eks/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}

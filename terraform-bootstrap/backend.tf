terraform {
  backend "s3" {
    bucket = "fm-my-unique-terraform-boot-game-bucket-2025"
    key    = "bootstrap/terraform.tfstate"
    region = "us-east-1"
  }
}
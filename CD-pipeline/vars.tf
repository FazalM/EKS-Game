variable "AWS_REGION" {
  default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "/users/fazal/.ssh/ecskey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "/users/fazal/.ssh/ecskey.pub"
}

variable "bucket_name" {
  description = "The name of the S3 bucket to store Terraform state"
  type        = string
  default     = "fm-my-unique-terraform-boot-game-bucket-2025"
}
##
variable "AWS_REGION" {
  default = "us-east-1"
}

variable "PATH_TO_PRIVATE_KEY" {
  default = "/users/fazal/.ssh/ecskey"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "/users/fazal/.ssh/ecskey.pub"
}

variable "AMIS" {
  type = map(string)
  default = {
    us-east-1 = "ami-084568db4383264d4"
    us-west-2 = "ami-075686beab831bb7f"
    eu-west-1 = "ami-04f7a54071e74f488"
  }
}

variable "bucket_name" {
  description = "The name of the S3 bucket to store Terraform state"
  type        = string
  default     = "fm-my-unique-terraform-boot-game-bucket-2025"
}

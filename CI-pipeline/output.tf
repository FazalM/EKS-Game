output "repository_uri" {
  value = aws_ecr_repository.my_ecr_app_repo.repository_url
  description = "The URI of the ECR repository"
}//

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnets
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "nat_gateway_ids" {
  value = module.vpc.natgw_ids
}

output "availability_zones" {
  value = module.vpc.azs
}

output "myinstance_sg_id" {
  value       = aws_security_group.myinstance.id
  description = "Security Group ID for my instance"
}

output "elb_sg_id" {
  value       = aws_security_group.elb-securitygroup.id
  description = "Security Group ID for the load balancer"
}
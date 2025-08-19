output "ecr_repository_uri" {
  value = aws_ecr_repository.my_eks_app_repo.repository_url
  description = "The URI of the ECR repository"
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "private_subnet_ids" {
  value = module.vpc.private_subnets
}

output "route53_zone_id" {
  value       = aws_route53_zone.public.zone_id
  description = "The ID of the Route 53 hosted zone"
}

output "route53_zone_name" {
  value       = aws_route53_zone.public.name
  description = "The domain name of the Route 53 hosted zone"
}

output "cluster_role_name" {
  value       = aws_iam_role.eks_cluster_role.name
  description = "The name of the EKS cluster IAM role"
}

output "cluster_role_arn" {
  value       = aws_iam_role.eks_cluster_role.arn
  description = "The ARN of the EKS cluster IAM role"
}

output "node_role_name" {
  value       = aws_iam_role.eks_node_role.name
  description = "The name of the EKS node IAM role"
}

output "node_role_arn" {
  value       = aws_iam_role.eks_node_role.arn
  description = "The ARN of the EKS node IAM role"
}

output "node_instance_profile_name" {
  value       = aws_iam_instance_profile.eks_node_instance_profile.name
  description = "The name of the EKS node instance profile"
}

output "eks_cluster_sg_id" {
  value       = aws_security_group.eks_cluster_sg.id
  description = "The security group ID for the EKS cluster control plane"
}

output "eks_node_sg_id" {
  value       = aws_security_group.eks_node_sg.id
  description = "The security group ID for the EKS worker nodes"
}
